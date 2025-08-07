<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseFormatter;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $fields = $request->validate([
            'username' => 'required|string|exists:users,username',
            'password' => 'required|string'
        ], [
            'username.exists' => 'User tidak ditemukan'
        ]);

        $user = User::where('username', $fields['username'])->first();
        if (!$user || !Hash::check($fields['password'], $user->password)) {
            return ResponseFormatter::error(code: 401, message: 'Username atau password salah');
        }

        $ability = $user->role === 'admin' ? ['admin'] : [];
        $token = $user->createToken($user->username, $ability)->plainTextToken;

        return ResponseFormatter::success(data: [
            'token' => $token,
            'role' => $user->role
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return ResponseFormatter::success(message: 'logout success');
    }
}
