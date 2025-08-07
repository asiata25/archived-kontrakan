<?php

namespace Database\Seeders;

use App\Models\Invoice;
use App\Models\Receipt;
use App\Models\RentalBlock;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Create 7 users who have their own blocks
        $users = User::factory(7)
            ->completeIdentity()
            ->has(RentalBlock::factory())
            ->create();

        // Create 13 invoices for each user including 3 pending, 1 debt, and 9 invoices
        $users->each(function (User $user) {
            $data = [
                'user_id' => $user->id,
                'user_fullname' => $user->fullname,
                'address' => $user->address,
                'identity_number' => $user->identity_number,
                'phone_number' => $user->phone_number,
                'rental_block_id' => $user->rentalBlock->id,
                'rental_block_name' => $user->rentalBlock->name,
                'entry_date' => $user->rentalBlock->entry_date,
                'price' => $user->rentalBlock->price,
                'deposit' => $user->rentalBlock->price,
            ];
            $debtData = array_merge($data, [
                'deposit' => $user->rentalBlock->price / 2,
            ]);

            Invoice::factory()->count(3)->has(Receipt::factory())->create($data);
            Invoice::factory()->count(1)->has(
                Receipt::factory()
                    ->state(function (array $attributes) use ($debtData) {
                        return ['amount' => $debtData['deposit']];
                    })
            )->debtPayment()->create($debtData);
            Invoice::factory()->count(9)->has(Receipt::factory())->isPaid()->create($data);
        });

        // Empty block
        RentalBlock::factory(2)->isEmpty()->create();
        // Deleted block
        RentalBlock::factory(2)->isEmpty()->trashed()->create();

        // Early registered user, not complete identity
        User::factory(2)->create();
        User::factory()
            ->has(RentalBlock::factory())
            ->create([
                'username' => 'penyewa',
                'password' => 'pass123',
            ]);
        // Deleted user
        User::factory(3)->trashed()->create();
        // Create an Admin
        User::factory()->create([
            'username' => 'admin',
            'password' => 'admin',
            'role' => 'admin'
        ]);
    }
}
