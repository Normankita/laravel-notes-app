<x-app-layout>
    <!-- Simplicity is an acquired taste. - Katharine Gerould -->
    <x-slot name='title'> Create </x-slot>
    <h1 class="rounded-lg p-4 m-5 bg-blue-400 text-gray-800 font-bold text-2xl">Create new note</h1>
    <form action="{{route('note.store')}}" method="POST" class="bg-gray-500 m-20 rounded-lg p-10 shadow-lg max-w-lg align-center">
        @csrf
        <div>
            <label for="title" class="text-gray-50 ml-5 ">Title</label>
            <input class="bg-gray-600 p-15 rounded-lg text-gray-50 m-5" type="text" name="title" id="title" placeholder="Title">
        </div>
        <div>
            <label for="note" class="text-gray-50 ml-5 ">Note</label>
            <textarea name="note" id="note" cols="30" rows="10" class="bg-gray-600 p-15 rounded-lg text-gray-50 m-5"></textarea>
        </div>
        <button type="submit" class="p-1 m-5  bg-gray-400 shadow-lg rounded-sm">Create</button> 
    </form><button class="p-1 m-5  bg-gray-800 shadow-lg rounded-sm"><a href="{{route('note.index')}}"> Cancel </a></button>
</x-app-layout>
