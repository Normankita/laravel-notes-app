<x-app-layout>
    <!-- An unexamined life is not worth living. - Socrates -->
    <x-slot name='title'>Edit</x-slot>
   <div>
        <h1>Edit note</h1>
        <form action="{{route('note.update', $note)}}" method="POST" class="bg-gray-500 m-20 rounded-lg p-10 shadow-lg max-w-lg align-center">
            @csrf
            @method('PUT')
            <div>
                <label for="title" class="text-gray-50 ml-5 ">Title</label>
                <input class="bg-gray-600 p-15 rounded-lg text-gray-50 m-5" type="text" name="title" id="title" placeholder="Title" value="{{$note->title}}">
            </div>
            <div>
                <label for="note" class="text-gray-50 ml-5 ">Note</label>
                <textarea class="bg-gray-600 p-15 rounded-lg text-gray-50 m-5" name="note" id="note" cols="30" rows="10">{{$note->note}}</textarea>
            </div>
            <button class="p-1 m-5  bg-gray-400 shadow-lg rounded-sm" type="submit">Update</button>
        </form>
        <a class="p-1 m-5  bg-gray-700 shadow-lg rounded-sm" href="{{route('note.index')}}">Back to Index</a>
   </div>
</x-app-layout>
