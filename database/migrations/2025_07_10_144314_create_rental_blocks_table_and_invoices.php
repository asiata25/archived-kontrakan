<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('invoices', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->string('user_fullname');
            $table->text('address');
            $table->string('identity_number', 20);
            $table->string('phone_number', 16);
            $table->string('rental_block_name');
            $table->timestamp('entry_date');
            $table->integer('price');
            $table->integer('deposit');
            $table->enum('status', ['paid', 'pending', 'debt', 'rejected'])->default('pending');
            $table->timestamp('billing_month');
            $table->text('notes')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('rental_blocks', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->integer('price');
            $table->uuid('user_id')->nullable()->unique();
            $table->foreign('user_id')->references('id')->on('users');
            $table->timestamp('entry_date')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::table('invoices', function (Blueprint $table) {
            $table->uuid('rental_block_id')->after('phone_number');
            $table->foreign('rental_block_id')->references('id')->on('rental_blocks');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('invoices');
        Schema::dropIfExists('rental_blocks');
    }
};
