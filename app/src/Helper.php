<?php

class Helper {
 
  public static function is_process_running($PID) {
    return file_exists( "/proc/$PID" );
  }
  public static function getPID(){
    $pid = shell_exec("pidof raspivid");
    return intval($pid);
  }
  public static function setIsRunning(){
    $GLOBALS["SETTINGS"]["state"]["running"] = Helper::is_process_running($GLOBALS["SETTINGS"]["pid"]);
  }
  public static function getJSONState(){
    return json_encode($GLOBALS["SETTINGS"]["state"]);
  }
  public static function takePicture(){
    $timestamp = time();
    $out = touch("/var/www/html/snapshot");
    sleep(2);
    $GLOBALS["SETTINGS"]["state"]["stdout"] = base64_encode(file_get_contents("/var/www/html/picture/picture.jpg"));
  }
  public static function recordVideo(){
    touch("/var/www/html/start_video");
    sleep(2);
    $GLOBALS["SETTINGS"]["pid"] = Helper::getPID();
    $GLOBALS["SETTINGS"]["state"]["running"] = Helper::is_process_running($GLOBALS["SETTINGS"]["pid"]);
  }
  public static function stopVideo(){
    shell_exec("kill ". $GLOBALS["SETTINGS"]["pid"]);
    Helper::setIsRunning();
    $GLOBALS["SETTINGS"]["pid"] = 0;
  }
 
}