<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseFormatter;
use App\Http\Resources\UserResource;
use App\Models\RentalBlock;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $users = User::with('rentalBlock')->where('role', 'user')->simplePaginate(20);

        return ResponseFormatter::paginate(data: [
            'users' => UserResource::collection($users),
        ], meta: $users);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $field = $request->validate([
            'username' => 'required|string|unique:users,username',
            'password' => 'required|string|min:3',
            'block_id' => 'sometimes|exists:rental_blocks,id',
            'entry_date' => 'sometimes|date'
        ]);

        $block = null;

        if ($request->has('block_id')) {
            $block = RentalBlock::find($field['block_id']);
            if (!$block) {
                return ResponseFormatter::error(code: 404, message: 'Blok tidak ditemukan');
            }

            if ($block->user_id) {
                return ResponseFormatter::error(code: 409, message: 'Blok sudah terpakai');
            }
        }

        $user = User::create($field);

        if ($block) {
            $block->update(
                ['user_id' => $user->id, 'entry_date' => $field['entry_date']]
            );
        }

        return ResponseFormatter::success(data: [
            'user' => [
                'id' => $user->id
            ]
        ], code: 201);
    }

    /**
     * Display the authenticated resource.
     */
    public function self()
    {
        $user = User::with('rentalBlock')->find(Auth::user()->id);
        return ResponseFormatter::success(data: [
            'user' => $user->toResource(),
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        $user->load('rentalBlock');
        return ResponseFormatter::success(data: [
            'user' => $user->toResource(),
        ]);
    }

    /**
     * Update the authenticated user resource in storage.
     */
    public function edit(Request $request)
    {
        $id = Auth::user()->id;
        return $this->modifyUser($id, $request);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(User $user, Request $request)
    {
        $id = $user->id;
        return $this->modifyUser($id, $request);
    }

    public function changeCredentials(Request $request)
    {
        $id = Auth::id();

        $request->validate([
            'username' => 'sometimes|string|unique:users,username',
            'password' => 'sometimes|string|confirmed|min:3',
        ], [
            'username.unique' => 'username sudah terpakai',
        ]);

        $isAdmin = Auth::user()->role == 'admin';
        if ($isAdmin) {
            $request->validate([
                'user_id' => 'required|exists:users,id'
            ]);

            $id = $request->user_id;
        }

        $user = User::find($id);
        if (!$user) {
            return ResponseFormatter::error(code: 404, message: 'user tidak ditemukan');
        }

        if (!$isAdmin && !Hash::check($request->password_old, $user->password)) {
            return ResponseFormatter::error(code: 401, message: 'Password lama tidak sesuai');
        }

        if ($request->has('password')) {
            $user->update([
                'password' => Hash::make($request->password)
            ]);
        }

        if ($request->has('username')) {
            $user->update([
                'username' => $request->username
            ]);
        }

        $user->save();
        return ResponseFormatter::success(code: 201);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        $user->delete();
        $user->rentalBlock()->update([
            'user_id' => null,
            'entry_date' => null
        ]);
        $user->tokens()->delete();
        return ResponseFormatter::success(message: 'user deleted');
    }

    public function modifyUser(string $userId, Request $request): JsonResponse
    {
        $field = $request->validate([
            'fullname' => 'sometimes|string',
            'address' => 'sometimes|string',
            'identity_number' => 'sometimes|string|max:20',
            'phone_number' => 'sometimes|string|max:16',
            'identity_image' => 'sometimes|image|max:1024',
        ]);

        $user = User::find($userId);
        if (!$user) {
            return ResponseFormatter::error(code: 404, message: 'user not found');
        }

        if ($request->hasFile('identity_image')) {
            $storagePath = str_replace(config('app.url') . '/storage/', '', $user->identity_image_url);

            if ($user->identity_image_url && Storage::disk('public')->exists($storagePath)) {
                Storage::disk('public')->delete($storagePath);
            }

            $image_url = $request->file('identity_image')->store('identity_images', 'public');
            $field['identity_image_url'] = $image_url;
        }

        $user->update($field);
        $user->save();

        return ResponseFormatter::success(data: [
            'user' => [
                'id' => $user->id
            ]
        ], code: 201);
    }
}
