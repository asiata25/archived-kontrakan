<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class InvoiceResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'deposit' => $this->deposit,
            'billing_month' => $this->billing_month,
            'status' => $this->status,
            'price' => $this->price,
            'rental_block' => RentalBlockResource::make($this->rentalBlock),
            'receipts' => ReceiptResource::collection($this->whenLoaded('receipts')),
        ];
    }
}
