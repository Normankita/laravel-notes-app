<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class MassiveUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $batchSize = 5000; // Don't insert too many at once

        for ($i = 0; $i < 200; $i++) {
            User::factory($batchSize)->create();
        }
    }
}
