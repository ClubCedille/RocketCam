<?php

class Helper {
 
  public static function is_process_running($PID) {
    return file_exists( "/proc/$PID" );
  }
  public static function raspividID(){
    $pid = shell_exec("pidof raspivid");
    return intval($pid);
  }
  public static function setIsRunning(){
    $GLOBALS["SETTINGS"]["state"]["running"] = Helper::is_process_running(Helper::raspividID());
  }
  public static function getJSONState(){
    return json_encode($GLOBALS["SETTINGS"]["state"]);
  }
  public static function takePicture(){
    $timestamp = time();
    touch("/var/www/html/snapshot");
    sleep(1);
    $GLOBALS["SETTINGS"]["state"]["stdout"] = base64_encode(file_get_contents("/var/www/html/picture/picture.jpg"));
  }
  public static function recordVideo(){
    touch("/var/www/html/start_video");
    sleep(2);
    Helper::setIsRunning();
  }
  public static function stopVideo(){
    touch("/var/www/html/stop_video");
    Helper::setIsRunning();
  }
 
}