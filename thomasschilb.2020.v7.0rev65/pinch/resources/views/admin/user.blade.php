@extends('layouts.admin')
@section('content')
<h3>User Info</h3>
<ul>
    <li>Account ID: {{ $user['account_id'] }}</li>
    <li>Name: {{ $user['name']['display_name'] }}</li>
    <li>Email: {{ $user['email'] }}</li>
    <li>Referral Link: <a href="{{ $user['referral_link'] }}">{{ $user['referral_link'] }}</a></li>
    <li>Account Type: {{ $user['account_type']['.tag'] }}</li>
</ul>
@stop