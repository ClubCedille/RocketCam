<?php
// Application middleware

$app->add(function ($request, $response, $next) {
	$response = $next($request, $response);
  file_put_contents(__DIR__."/../session.json", json_encode($GLOBALS["SETTINGS"]));
	return $response;
});
