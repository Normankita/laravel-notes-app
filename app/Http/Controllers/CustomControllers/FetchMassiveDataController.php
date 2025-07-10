<?php

namespace App\Http\Controllers\CustomControllers;

use App\Exports\UsersExport;
use App\Http\Controllers\Controller;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Http\Request;

class FetchMassiveDataController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return view("all-users");
    }

    public function export(Request $request)
    {
        ini_set('max_execution_time', 300); 
        $filters = $request->only(['name', 'start_date', 'end_date']);
        return Excel::download(new UsersExport($filters), 'users.xlsx');
    }

}
