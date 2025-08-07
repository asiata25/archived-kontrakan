<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\UserController;
use App\Models\User;
use Illuminate\Support\Facades\Route;


Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::get('/users', [UserController::class, 'self']);
    Route::post('/users', [UserController::class, 'edit']);
    Route::put('/users/credentials', [UserController::class, 'changeCredentials']);

    Route::get('/invoices', [InvoiceController::class, 'index']);
    Route::get('/invoices/{invoice}', [InvoiceController::class, 'show']);
    Route::post('/invoices', [InvoiceController::class, 'store']);
    Route::post('/invoices/{invoice}/receipts', [InvoiceController::class, 'addReceipt']);
    Route::post('/invoices/{invoice}/receipts/{receipt}', [InvoiceController::class, 'updateReceipt']);
});
