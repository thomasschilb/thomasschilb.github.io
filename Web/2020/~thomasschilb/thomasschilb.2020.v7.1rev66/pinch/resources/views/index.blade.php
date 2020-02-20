@extends('layouts.default')

@section('content')
<form method="POST">
	<input type="hidden" name="_token" value="{{{ csrf_token() }}}" />
	<button class="button">Login with Dropbox</button>
</form>
@stop