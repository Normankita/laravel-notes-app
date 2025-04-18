<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class MyCustomController extends Controller
{
    public function index()
    {
        return view('my_custom_view');
    }
    public function show($id)
    {
        // Logic to retrieve and show a specific item
        return view('my_custom_show', ['id' => $id]);
    }
}
