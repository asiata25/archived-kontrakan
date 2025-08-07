<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseFormatter;
use App\Http\Resources\InvoiceResource;
use App\Models\Invoice;
use App\Models\Receipt;
use App\Models\User;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\In;

class InvoiceController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = Auth::user();
        $invoices = Invoice::where('user_id', $user->id)->orderBy('billing_month', 'desc')->simplePaginate(12);

        return ResponseFormatter::paginate(data: [
            'invoices' => $invoices->toResourceCollection(),
        ], meta: $invoices);
    }

    /**
     * Display a listing of the resource.
     */
    public function list(Request $request)
    {
        // Get filters from query string
        $startDate = $request->query('start_date');
        $endDate = $request->query('end_date');
        $status = $request->query('status');

        $query = Invoice::query();

        // Filter by start date
        if ($startDate) {
            $query->where('billing_month', '>=', $startDate);
        }

        // Filter by end date
        if ($endDate) {
            $query->where('billing_month', '<=', $endDate);
        }

        // Filter by status
        if ($status) {
            $query->where('status', $status);
        }

        // Clone query before pagination to calculate total deposit
        $totalDeposit = (clone $query)->sum('deposit');

        $invoices = $query->orderBy('billing_month', 'desc')->simplePaginate(12);

        return ResponseFormatter::paginate(data: [
            'invoices' => $invoices->toResourceCollection(),
            'total_deposit' => $totalDeposit
        ], meta: $invoices);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $field = $request->validate([
            'billing_month' => 'required|date',
            'amount' => 'required|numeric',
            'receipt' => 'required|image|max:1024',
        ], [
            'receipt.max' => 'Ukuran file bukti pembayaran tidak boleh lebih dari 1MB'
        ]);
        $user = User::with('rentalBlock')->find(Auth::user()->id);
        $rentalBlock = $user->rentalBlock;

        if ($field['amount'] > $rentalBlock->price) {
            return ResponseFormatter::error(code: 400, message: 'Jumlah tagihan tidak boleh melebihi harga sewa');
        }

        if (
            !$user->address ||
            !$user->identity_number ||
            !$user->phone_number ||
            !$rentalBlock
        ) {
            return ResponseFormatter::error(code: 400, message: 'user data not complete');
        }

        $invoice = $user->invoices()
            ->whereMonth('billing_month', date('m', strtotime($field['billing_month'])))
            ->whereYear('billing_month', date('Y', strtotime($field['billing_month'])))
            ->first();
        if ($invoice) {
            return ResponseFormatter::error(code: 400, message: 'Invoice sudah ada');
        }

        $invoice = $user->invoices()->create([
            'user_fullname' => $user->fullname,
            'address' => $user->address,
            'identity_number' => $user->identity_number,
            'phone_number' => $user->phone_number,
            'rental_block_id' => $rentalBlock->id,
            'rental_block_name' => $rentalBlock->name,
            'entry_date' => $rentalBlock->entry_date,
            'price' => $rentalBlock->price,
            'deposit' => $field['amount'],
            'billing_month' => $field['billing_month'],
            'notes' => 'Sedang menunggu verifikasi oleh admin'
        ]);

        $request->merge([
            'payment_date' => now()
        ]);
        $this->addReceiptToInvoice($invoice, $request);

        return ResponseFormatter::success(code: 201, data: [
            'invoice' => [
                'id' => $invoice->id
            ]
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Invoice $invoice)
    {
        $response = Gate::inspect('modify', $invoice);
        if ($response->denied()) {
            return ResponseFormatter::error(code: 403, message: $response->message());
        }

        $invoice->load('receipts');
        $userData = [
            'fullname' => $invoice->user_fullname,
            'address' => $invoice->address,
            'identity_number' => $invoice->identity_number,
            'phone_number' => $invoice->phone_number
        ];

        /** @var \Laravel\Sanctum\HasApiTokens|\App\Models\User $user */
        $user = Auth::user();
        if ($user->tokenCan('admin')) {
            $userData['id'] = $invoice->user_id;
        }

        $invoice = array_merge($invoice->toResource()->toArray(request()), [
            'user' => $userData,
            'notes' => $invoice->notes
        ]);

        return ResponseFormatter::success(data: [
            'invoice' => $invoice
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Invoice $invoice)
    {
        $field = $request->validate([
            'status' => ['required', Rule::in(['rejected', 'paid', 'debt', 'pending'])],
            'notes' => 'required|string',
        ], [
            'notes.required' => 'Catatan tidak boleh kosong',
        ]);

        $invoice->update($field);
        $invoice->save();

        return ResponseFormatter::success(data: [
            'invoice' => [
                'id' => $invoice->id
            ]
        ], code: 201);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Invoice $invoice)
    {
        $receipts = $invoice->receipts;
        foreach ($receipts as $receipt) {
            // Delete the file if exists
            if ($receipt->url && Storage::exists($receipt->url)) {
                Storage::delete($receipt->url);
            }
            $receipt->forceDelete(); // Delete receipt from DB
        }
        $invoice->forceDelete();

        return ResponseFormatter::success(message: 'invoice deleted');
    }

    public function addReceipt(Invoice $invoice, Request $request)
    {
        $response = Gate::inspect('modify', $invoice);
        if ($response->denied()) {
            return ResponseFormatter::error(code: 403, message: $response->message());
        }

        if ($invoice->status == 'paid') {
            return ResponseFormatter::error(code: 400, message: 'Invoice sudah lunas');
        }

        $field = $request->validate([
            'amount' => 'required|numeric',
            'receipt' => 'required|image|max:1024',
            'payment_date' => 'required|date',
        ]);

        $deposit = $invoice->deposit + $field['amount'];
        if ($deposit > $invoice->price) {
            return ResponseFormatter::error(code: 400, message: 'Jumlah bayar tidak boleh melebihi harga sewa');
        }


        $this->addReceiptToInvoice($invoice, $request);
        $invoice->update([
            'deposit' => $deposit,
            'status' => 'pending',
            'notes' => 'Sedang menunggu verifikasi oleh admin'
        ]);
        $invoice->save();

        return ResponseFormatter::success(code: 201, data: [
            'invoice' => [
                'id' => $invoice->id
            ]
        ]);
    }

    public function updateReceipt(Invoice $invoice, Receipt $receipt, Request $request)
    {
        $response = Gate::inspect('modify', $invoice);
        if ($response->denied()) {
            return ResponseFormatter::error(code: 403, message: $response->message());
        }

        $field = $request->validate([
            'amount' => 'required|numeric',
            'receipt' => 'sometimes|image|max:1024',
            'payment_date' => 'required|date',
        ]);

        $deposit = $invoice->deposit - $receipt->amount + $field['amount'];
        if ($deposit > $invoice->price) {
            return ResponseFormatter::error(code: 400, message: 'Jumlah bayar tidak boleh melebihi harga sewa');
        }

        if ($request->hasFile('receipt')) {
            $storagePath = str_replace(config('app.url') . '/storage/', '', $receipt->url);

            if (Storage::disk('public')->exists($storagePath)) {
                Storage::disk('public')->delete($storagePath);
            }

            $this->addReceiptToInvoice($invoice, $request);
            $receipt->forceDelete();
        } else {
            $receipt->update([
                'payment_date' => $request->input('payment_date'),
                'amount' => $request->input('amount'),
            ]);
            $receipt->save();
        }
        $invoice->update([
            'deposit' => $deposit,
            'status' => 'pending',
            'notes' => 'Sedang menunggu verifikasi oleh admin'
        ]);
        $invoice->save();

        return ResponseFormatter::success(data: [
            'invoice' => [
                'id' => $invoice->id
            ]
        ], code: 201);
    }

    function addReceiptToInvoice(Invoice $invoice, Request $request)
    {
        $image_url = $request->file('receipt')->store('receipts', 'public');
        $invoice->receipts()->create([
            'payment_date' => $request->input('payment_date'),
            'amount' => $request->input('amount'),
            'url' => $image_url
        ]);
    }
}
