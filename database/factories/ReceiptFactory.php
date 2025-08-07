<?php

namespace Database\Factories;

use App\Models\Invoice;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Receipt>
 */
class ReceiptFactory extends Factory
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
            'invoice_id' => Invoice::factory(),
            'payment_date' => fake()->dateTimeBetween('-1 week', 'now'),
            'amount' => fake()->numberBetween(500000, 2500000),
            'url' => fake()->url()
        ];
    }
}
