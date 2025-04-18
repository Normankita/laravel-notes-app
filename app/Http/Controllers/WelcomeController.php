<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WelcomeController extends Controller
{
    public function index()
    {
        return 'index';
    }
    public function show($id)
    {
        // Logic to retrieve and show a specific item
        return 'show';
    }
    public function create()
    {
        // Logic to show a form for creating a new item
        return 'create';
    }
    public function store(Request $request)
    {
        // Logic to store a new item
        // $request->validate([...]);
        // Item::create($request->all());
        return redirect()->route('welcome.index');
    }
    public function edit($id)
    {
        // Logic to show a form for editing an existing item
        return 'edit';
    }
    public function update(Request $request, $id)
    {
        // Logic to update an existing item
        // $request->validate([...]);
        // Item::find($id)->update($request->all());
        return redirect()->route('welcome.index');
    }
    public function destroy($id)
    {
        // Logic to delete an existing item
        // Item::find($id)->delete();
        return redirect()->route('welcome.index');
    }
    public function customMethod()
    {
        // Custom logic for this method
        return view('welcome');
    }
}
