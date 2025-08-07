<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * The current password being used by the factory.
     */
    protected static ?string $password;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'id' => fake()->uuid(),
            'username' => fake()->userName(),
            'password' => static::$password ??= Hash::make('password'),
        ];
    }

    public function completeIdentity(): Factory
    {
        return $this->state(function (array $attributes) {
            return [
                'fullname' => fake('id_ID')->name(),
                'address' => fake()->address(),
                'phone_number' => fake()->numerify('08##########'),
                'identity_number' => fake()->numerify('3506############'),
                'identity_image_url' => fake()->imageUrl(),
            ];
        });
    }
}
