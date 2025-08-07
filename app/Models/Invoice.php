<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;

class Invoice extends Model
{
    use HasFactory, SoftDeletes, HasUuids;

    protected $fillable = [
        'billing_month',
        'user_fullname',
        'address',
        'identity_number',
        'phone_number',
        'rental_block_id',
        'rental_block_name',
        'entry_date',
        'price',
        'deposit',
        'status',
        'notes',
    ];


    public function rentalBlock(): BelongsTo
    {
        return $this->belongsTo(RentalBlock::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function receipts(): HasMany
    {
        return $this->hasMany(Receipt::class);
    }
}
