<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Member extends Model
{
    protected $table = 'member';
    protected $primaryKey = 'NATIONAL_ID'; // if applicable

    public function employer()
    {
        return $this->belongsTo(Employer::class, 'EMPLOYER_ID', 'EMPLOYER_ID');
    }
}

