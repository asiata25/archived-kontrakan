<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'username' => $this->username,
            'address' => $this->address,
            'fullname' => $this->fullname,
            'identity_number' => $this->identity_number,
            'identity_image_url' => $this->identity_image_url,
            'phone_number' => $this->phone_number,
            'id' => $this->when($request->user()->tokenCan('admin'), $this->id),
            'rental_block' => RentalBlockResource::make($this->whenLoaded('rentalBlock')),
        ];
    }
}
