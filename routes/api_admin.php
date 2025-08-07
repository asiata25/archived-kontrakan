<?php

use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\RentalBlockController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum', 'abilities:admin'])->group(function () {
    Route::apiResource('/users', UserController::class);

    Route::apiResource('/blocks', RentalBlockController::class)->except(['show']);
    Route::delete('/blocks/{block}/users', [RentalBlockController::class, 'detachUser']);
    Route::get('/blocks/empty', [RentalBlockController::class, 'emptyBlocks']);

    Route::get('/invoices', [InvoiceController::class, 'list']);
    Route::put('/invoices/{invoice}', [InvoiceController::class, 'update']);
    Route::delete('/invoices/{invoice}', [InvoiceController::class, 'destroy']);
});
