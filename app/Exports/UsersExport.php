<?php

namespace App\Exports;

use Illuminate\Support\Facades\DB;
use Generator;
use Maatwebsite\Excel\Concerns\FromGenerator;
use Maatwebsite\Excel\Concerns\WithHeadings;

class UsersExport implements FromGenerator, WithHeadings
{
    protected $filters;

    public function __construct(array $filters = [])
    {
        $this->filters = $filters;
    }

    public function generator(): Generator
    {
        $query = DB::table('users')->select('id', 'name', 'email', 'dob', 'created_at');

        if (!empty($this->filters['name'])) {
            $query->where('name', 'like', '%' . $this->filters['name'] . '%');
        }

        if (!empty($this->filters['start_date'])) {
            $query->whereDate('dob', '>=', $this->filters['start_date']);
        }

        if (!empty($this->filters['end_date'])) {
            $query->whereDate('dob', '<=', $this->filters['end_date']);
        }

        foreach ($query->orderBy('id')->cursor() as $row) {
            yield [
                $row->id,
                $row->name,
                $row->email,
                $row->dob,
                $row->created_at,
            ];
        }
    }

    public function headings(): array
    {
        return ['ID', 'Name', 'Email', 'DOB', 'Created At'];
    }
}
