<?php

namespace App\Http\Controllers;

use App\Models\Note;
use Illuminate\Http\Request;

class NoteController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $notes = Note::query()
        ->where('user_id', request()->user()->id) // Assuming you have a logged-in user 1, but usually it is auth()->user()->id
        ->orderBy("created_at", "desc")
        ->paginate();
        return view('note.index', [
            'notes' => $notes,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('note.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $data= $request->validate([
            'title' => ['required', 'string', 'max:255'],
            'note' => ['required', 'string', 'max:2000'],
        ]);
        $data['user_id'] = auth()->user()->id;
        // $data['user_id'] = auth()->user()->id; // If you have authentication set up
        // $data['user_id'] = auth()->id(); // If you have authentication set up
        $data['created_at'] = now();
        Note::create($data);

        return redirect()->route('note.index')->with('success', 'Note created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Note $note)
    {
        if($note->user_id !== auth()->user()->id) {
            // Check if the note belongs to the authenticated user
            abort(403, 'Unauthorized action.');
        }
        return view('note.show', compact('note'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Note $note)
    {
        if($note->user_id !== auth()->user()->id) {
            // Check if the note belongs to the authenticated user
            abort(403, 'Unauthorized action.');
        }
        return view('note.edit', compact('note'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Note $note)
    {
        if($note->user_id !== auth()->user()->id) {
            // Check if the note belongs to the authenticated user
            abort(403, 'Unauthorized action.');
        }
        $data= $request->validate([
            'title' => ['required', 'string', 'max:255'],
            'note' => ['required', 'string', 'max:2000'],
        ]);
        
        $data['updated_at'] = now();
        $note->update($data);

        return redirect()->route('note.show', $note)->with('success', 'Note updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Note $note)
    {
        if($note->user_id !== auth()->user()->id) {
            // Check if the note belongs to the authenticated user
            abort(403, 'Unauthorized action.');
        }
        $note->delete();
        return redirect()->route('note.index')->with('success', 'Note deleted successfully.');
    }
}
