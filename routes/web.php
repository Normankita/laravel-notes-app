<?php

use App\Http\Controllers\CustomControllers\FetchMassiveDataController;
use App\Http\Controllers\NoteController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\WelcomeController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

// Route::get('/dashboard', function () {
//     return view('dashboard');
// })->middleware(['auth', 'verified'])->name('dashboard');
Route::redirect('/', '/note')->name('dashboard');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::resource('note', NoteController::class);
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::prefix('/normal')
    ->controller(FetchMassiveDataController::class)
    ->name('normal')
    ->group(function () {
        Route::get('/users', 'index')->name('.users.index');
        Route::get('/users/export', 'export')->name('.users.export');
        Route::get('/contributions/export', 'exportContributions')->name('.contributions.export');
    });

// Route::get('/some', [WelcomeController::class ,  'index'])->name('welcome.index');
// Route::get('note', [NoteController::class, 'index'])->name('note.index');
// Route::get('note/create', [NoteController::class, 'create'])->name('note.create');
// Route::post('note', [NoteController::class, 'store'])->name('note.store');
// Route::get('note/{id}', [NoteController::class, 'show'])->name('note.show');
// Route::get('note/{id}/edit', [NoteController::class, 'edit'])->name('note.edit');
// Route::put('note/{id}', [NoteController::class, 'update'])->name('note.update');
// Route::delete('note/{id}', [NoteController::class, 'destroy'])->name('note.destroy');




require __DIR__ . '/auth.php';
