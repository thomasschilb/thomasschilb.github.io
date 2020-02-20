@extends('layouts.admin')
@section('content')
<h3>Upload</h3>
<form method="POST" enctype="multipart/form-data">
	<input type="hidden" name="_token" value="{{{ csrf_token() }}}" />
	<p>
		<label for="path">Path</label>
		<input type="text" name="path" id="path">
	</p>
	<p>
		<label for="file">File</label>
		<input type="file" name="file" id="file">
	</p>
	<button>upload</button>
</form>
@stop