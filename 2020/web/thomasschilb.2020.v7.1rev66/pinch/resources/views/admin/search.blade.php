@extends('layouts.admin')
@section('content')
<h3>Search</h3>
<form method="GET">
	<p>
		<label for="path">Path</label>
		<input type="text" name="path" id="path" value="{{ $path }}">
	</p>
	<p>
		<label for="query">Query</label>
		<input type="search" name="query" id="query" value="{{ $query }}">
	</p>
	<button>Search</button>
</form>

@if(count($matches) > 0)
<h5>Search Results</h5>
<table>
	<thead>
		<tr>
			<th>Filename</th>
			<th>Revisions</th>
			<th>Download</th>
		</tr>
	</thead>
	<tbody>
		@foreach($matches as $match)
		<tr>
			<td>{{ $match['metadata']['name'] }}</td>
			<td><a href="/revisions?path={{ urlencode($match['metadata']['path_lower']) }}">view</a></td>
			<td><a href="/download?path={{ urlencode($match['metadata']['path_lower']) }}">download</a></td>
		</tr>
		@endforeach
	</tbody>
</table>
@endif
@stop