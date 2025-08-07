<?php

namespace Database\Factories;

use App\Models\RentalBlock;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
 */
class InvoiceFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id' => fake()->uuid(),
            'user_id' => User::factory(),
            'rental_block_id' => RentalBlock::factory(),
            'price' => fake()->numberBetween(500000, 2500000),
            'deposit' => fake()->numberBetween(200000, 1500000),
            'billing_month' => fake()->dateTimeBetween('-3 months', 'now'),
            'status' => 'pending',
            'notes' => "menunggu untuk ditinjau oleh admin"
        ];
    }

    public function isPaid(): Factory
    {
        return $this->state(function (array $attributes) {
            return [
                'status' => 'paid',
                'notes' => "pembayaran telah lunas"
            ];
        });
    }

    public function debtPayment(): Factory
    {
        return $this->state(function (array $attributes) {
            return [
                'status' => 'debt',
                'notes' => "harap segera melunasi pemayaran"
            ];
        });
    }
}
