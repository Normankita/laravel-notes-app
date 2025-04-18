<x-app-layout>
    <!-- Because you are alive, everything is possible. - Thich Nhat Hanh -->
    <x-slot name="title" >Index</x-slot>
    <div class="bg-gray-200 m-20 rounded-lg p-10 shadow-lg">
        <h1 class="font-bold m-10 text-4xl">All  Notes</h1>
        <a class="rounded-lg p-4 m-5 bg-blue-400 text-gray-800" href="{{route('note.create')}}">Create New Note</a>
        <ul class="grid grid-cols-3 gap-2 m-10 p-5 overflow-auto ">
            @foreach($notes as $note)
                <li class="sm:bg-gray-300 dark:bg-gray-800 dark:text-gray-200 p-4 rounded-lg shadow-3xl p-30 col-span-1">
                    <a class="bg-gray-700 p-1" href="{{route('note.show', $note)}}">{{$note->title}}</a>
                    <p>{{Str::words($note->note, 30)}}</p>
                    <a class="p-1 m-5  bg-gray-400 shadow-lg rounded-sm" href="{{route('note.edit', $note)}}"> Edit Note</a>
                    <form action="{{route('note.destroy', $note)}}" method="POST">
                        @csrf
                        @method('DELETE')
                        <button class="p-1 m-5 bg-red-300 shadow-lg rounded-sm" type="submit">Delete</button>
                    </form>
                    
                </li>
            @endforeach
        </ul>
        {{$notes->links()}}
    </div>
</x-app-layout>
