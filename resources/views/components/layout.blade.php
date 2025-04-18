<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>{{$title?? 'My new app'}}</title>
    {{-- importing app.css via vite --}}
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    {{-- importing bootstrap via cdn --}}
</head>
<body class=" bg-gray-200 dark:bg-gray-700">
    @session('success')
        <div class="bg-green-500 text-white p-4 rounded-lg m-5">
            {{session('success')}}
        </div>
    @endsession
    {{$slot}}
</body>
</html>
