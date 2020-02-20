@extends('layouts.admin')
@section('content')
<h3>Revisions</h3>
<strong>File: </strong> {{ $path }}
<table>
	<thead>
		<tr>
			<th>Revision ID</th>
			<th>Modified</th>
			<th>Size (Bytes)</th>
			<th>Restore</th>
		</tr>
	</thead>
	<tbody>
		@foreach($revisions as $rev)
		<tr>
			<td>{{ $rev['rev'] }}</td>
			<td>{{ Carbon\Carbon::parse($rev['server_modified'])->setTimezone(env('APP_TIMEZONE'))->toDayDateTimeString() }}</td>
			<td>{{ $rev['size'] }}</td>
			<td><a href="/restore?path={{ urlencode($rev['path_lower']) }}&rev={{ $rev['rev'] }}">restore</a></td>
		</tr>
		@endforeach
	</tbody>
</table>
@stop