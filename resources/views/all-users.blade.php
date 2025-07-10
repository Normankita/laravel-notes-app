<div>
    <form method="GET" action="{{ route('normal.users.export') }}">
        <input type="text" name="name" placeholder="Name">
        <input type="date" name="start_date" placeholder="DOB from">
        <input type="date" name="end_date" placeholder="DOB to">
        <button type="submit">Export Excel</button>
    </form>
    @if (empty(request('name')) && empty(request('start_date')) && empty(request('end_date')))
        <p style="color: red;">You're about to export all users. This may take time.</p>
    @endif
</div>
