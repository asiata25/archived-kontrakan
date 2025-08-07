<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class RentalBlockResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'name' => $this->name,
            'price' => $this->price,
            'entry_date' => $this->entry_date,
            'id' => $this->when($request->user()->tokenCan('admin'), $this->id),
            'user_id' => $this->when($request->user()->tokenCan('admin'), $this->user_id),
        ];
    }
}
