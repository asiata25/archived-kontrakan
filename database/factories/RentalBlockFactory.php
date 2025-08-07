<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
 */
class RentalBlockFactory extends Factory
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
            'name' => fake()->numerify('BLK-###'),
            'price' => fake()->randomElement(range(500000, 2500000, 150000)),
            'entry_date' => fake()->dateTimeBetween('-3 months', 'now')
        ];
    }

    public function isEmpty(): Factory
    {
        return $this->state(function (array $attributes) {
            return [
                'user_id' => null,
                'entry_date' => null,
            ];
        });
    }
}
