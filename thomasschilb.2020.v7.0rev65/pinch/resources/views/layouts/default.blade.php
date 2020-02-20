<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>{{ env('APP_TITLE') }}</title>
	<link rel="stylesheet" href="{{ secure_asset('assets/lib/picnic/picnic.min.css') }}">
	<link rel="stylesheet" href="{{ secure_asset('assets/css/style.css') }}">
</head>
<body>
	<div id="wrapper">
		<h1>{{ env('APP_TITLE') }}</h1>
		@yield('content')
	</div>
</body>
</html>