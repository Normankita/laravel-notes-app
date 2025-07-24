<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Contribution extends Model
{
    protected $table = 'contribution';

    public function member()
    {
        return $this->belongsTo(Member::class, 'NATIONAL_ID', 'NATIONAL_ID');
    }

    public function employer()
    {
        return $this->belongsTo(Employer::class, 'EMPLOYER_ID', 'EMPLOYER_ID');
    }
}

