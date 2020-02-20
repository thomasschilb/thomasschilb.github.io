<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

Route::get('/', 'HomeController@index');
Route::post('/', 'HomeController@postIndex');

Route::get('/login', 'HomeController@login');

Route::group(
	['middleware' => ['admin']], 
	function($app){	
		Route::get('/dashboard', 'AdminController@dashboard');

		Route::get('/user', 'AdminController@user');

		Route::get('/search', 'AdminController@search');

		Route::get('/upload', 'AdminController@upload');
		Route::post('/upload', 'AdminController@doUpload');

		Route::get('/revisions', 'AdminController@revisions');
		Route::get('/restore', 'AdminController@restoreRevision');

		Route::get('/download', 'AdminController@download');
});