<?php

namespace Database\Seeders;

use App\Models\Note;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class NoteSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
        public function run(): void
    {
        $batchSize = 500; // Don't insert too many at once

        for ($i = 0; $i < 20; $i++) {
            Note::factory($batchSize)->create();
        }
    }
}
