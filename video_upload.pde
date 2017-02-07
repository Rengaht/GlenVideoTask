

// qvalue: 0 is lossless, 23 is default, and 51 is worst possible
void combineVideo(String id_){
  
  writeLog("Combine video...");  
  
  File ffmpeg_output_msg = new File(sketchPath()+"\\ffmpeg_output.txt");
  
  
  ProcessBuilder pb = new ProcessBuilder(_global.FFmpegPath,
    "-y",
    "-i", _global.WavFolder+id_+".wav",
    "-i",_global.VideoFile,    
    "-filter_complex",
    "[0:a]adelay=9180|9180,afade=t=in:st=9:d=3,afade=t=out:st=17:d=3[a0];[a0][1:a]amix=inputs=2[a]",
    "-map","1:v",
    "-map","[a]",
    "-c:v","libx264","-crf",String.valueOf(_global.VideoQuality),"-c:a","aac","-b:a","128k",
    _global.OutputFolder+id_+".mp4");
     
  pb.redirectErrorStream(true);
  pb.redirectOutput(ffmpeg_output_msg);
  
  try{
    Process p = pb.start(); 
    p.waitFor();
    writeLog("Finish Combine Video...");
    
    
  }catch(Exception e){
    writeLog("init error: "+e);
  } 
  
  
}

void uploadVideo(String id_){
  
  writeLog("Upload video: "+id_+"...");
  
  String file_path=_global.OutputFolder+id_+".mp4";
  File file=new File(file_path);
  if(!file.exists() || file.isDirectory()){
    writeLog("No such file:"+file_path);  
    return;
  }
  
  PostRequest post = new PostRequest(_global.ServerURL+"/action.php");
  post.addData("action", "upload_video");   
  post.addData("guid",id_);  
  post.addFile("file",file_path);
  post.send();
  
  writeLog("Reponse Content: " + post.getContent());
 
  //JSONObject res_=parseJSONObject(post.getContent());  
  //if(res_.getString("result").equals("success")) return res_.getString("guid");
  //return "";
  
}