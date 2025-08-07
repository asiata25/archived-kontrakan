<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseFormatter;
use App\Models\RentalBlock;
use Illuminate\Http\Request;

class RentalBlockController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $rentalBlocks = RentalBlock::orderBy('updated_at', 'desc')->simplePaginate(20);
        return ResponseFormatter::paginate(data: [
            'rental_blocks' => $rentalBlocks->toResourceCollection()
        ], meta: $rentalBlocks);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request = $this->modifyBlock($request);
        $block = RentalBlock::create($request->all());

        return ResponseFormatter::success(data: [
            'rental_block' => [
                'id' => $block->id
            ]
        ], code: 201);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, RentalBlock $block)
    {
        $request = $this->modifyBlock($request);
        $block->update($request->all());
        $block->save();

        return ResponseFormatter::success(data: [
            'rental_block' => [
                'id' => $block->id
            ]
        ], code: 201);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(RentalBlock $block)
    {
        $block->update([
            'user_id' => null,
            'entry_date' => null
        ]);
        $block->delete();
        return ResponseFormatter::success(message: 'rental block deleted');
    }

    public function detachUser(RentalBlock $block)
    {
        $block->update([
            'user_id' => null,
            'entry_date' => null
        ]);
        $block->save();

        return ResponseFormatter::success(message: 'user detached');
    }

    public function modifyBlock(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'price' => 'required|integer',
            'user_id' => 'sometimes|exists:users,id|unique:rental_blocks,user_id',
            'entry_date' => 'sometimes|date'
        ], [
            'user_id.exists' => 'user not found',
            'user_id.unique' => 'user already has a rental block'
        ]);

        return $request;
    }
}
