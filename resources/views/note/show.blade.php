<x-app-layout>
    <!-- I begin to speak only when I am certain what I will say is not better left unsaid. - Cato the Younger -->
    <x-slot name="title">Show</x-slot>
    <div class="bg-gray-500 m-10 rounded shadow-lg p-5">
        <h1 class="font-bold m-10 text-4xl">{{$note->title}} </h1>
        <a href="{{route('note.create')}}" class="rounded-lg p-4 m-5 bg-blue-400 text-gray-800">Create New Note</a>
        <ul class="bg-gray-300 p-10 m-5 rounded">
            <li>
                <p>{{$note->note}}</p>
                <p>Created at {{$note->created_at}}</p>
                <a href="{{route('note.edit', $note)}}"> Edit Note</a>
                <form action="{{route('note.destroy', $note)}}" method="POST">
                    @csrf
                    @method('DELETE')
                    <button type="submit">Delete</button>
                </form>
            </li>
        </ul>
        <a class="p-1 m-5  bg-gray-700 shadow-lg rounded-sm text-gray-200" href="{{route('note.index')}}">Back to Index</a>
</x-app-layout>
