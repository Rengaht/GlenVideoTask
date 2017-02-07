

class GlobalParameter{
  
  String OrderFolder; // where order files
  String WavFolder; // where wav files
  String OutputFolder; // where output video files
  String VideoFile;
  String AudioFile;
  String FFmpegPath;
  
  String ServerURL;
  
  int VideoQuality;
  
  String LocalIP;
  int IPStart;
  
  int ClientFull;
  int ClientCount;
  
  
  GlobalParameter(){
     readParam();
     
     
  }
  
  void readParam(){
    
    XML param_xml;
    try{
      param_xml=loadXML("data\\param_file.xml");
    }catch(Exception e){
      println("No existing fil, write param...");
      writeParam();
      return;
    }
    println("__Read Parameters__");
    
    OrderFolder=param_xml.getChildren("ORDER_FOLDER")[0].getContent();
    println("__OrderFolder= "+OrderFolder);
    
    OutputFolder=param_xml.getChildren("OUTPUT_FOLDER")[0].getContent();
    println("__OutputFolder= "+OutputFolder);

    WavFolder=param_xml.getChildren("WAV_FOLDER")[0].getContent();
    println("__WavFolder= "+WavFolder);

    VideoFile=param_xml.getChildren("VIDEO_FILE")[0].getContent();
    println("__VideoFile= "+VideoFile);
    
    AudioFile=param_xml.getChildren("AUDIO_FILE")[0].getContent();
    println("__VideoFile= "+AudioFile);
  
    FFmpegPath=param_xml.getChildren("FFMPEG_PATH")[0].getContent();
    println("__FFmpegPath= "+FFmpegPath);
    
    ServerURL=param_xml.getChildren("SERVER_URL")[0].getContent();
    println("__ServerURL= "+ServerURL);    
    
    VideoQuality=parseInt(param_xml.getChildren("VIDEO_QUALITY")[0].getContent());
    println("__VideoQuality= "+VideoQuality);
         
    LocalIP=param_xml.getChildren("LOCAL_IP")[0].getContent();
    println("__LocalIP= "+LocalIP);    
    IPStart=parseInt(param_xml.getChildren("IP_START")[0].getContent());
    println("__IPStart= "+IPStart);    
    
    ClientFull=parseInt(param_xml.getChildren("CLIENT_FULL")[0].getContent());
    println("__ClientFull= "+ClientFull);
    ClientCount=parseInt(param_xml.getChildren("CLIENT_COUNT")[0].getContent());
    println("__ClientNum= "+ClientCount);
  }
  
  void writeParam(){
    XML xml=new XML("PARAM");
       
     
    XML of=xml.addChild("ORDER_FOLDER");
    of.setContent(OrderFolder);
    
    XML pf=xml.addChild("OUTPUT_FOLDER");
    pf.setContent(OutputFolder);    
            
    XML wf=xml.addChild("WAV_FOLDER");
    wf.setContent(WavFolder);
    
    XML vf=xml.addChild("VIDEO_FILE");
    vf.setContent(VideoFile);
    XML af=xml.addChild("AUDIO_FILE");
    af.setContent(AudioFile);
    
    XML fp=xml.addChild("FFMPEG_PATH");
    fp.setContent(FFmpegPath);
    

    XML surl=xml.addChild("SERVER_URL");
    surl.setContent(ServerURL);             
  
    XML lip=xml.addChild("LOCAL_IP");
    lip.setContent(LocalIP);             
    XML is=xml.addChild("IP_START");
    is.setContent(str(IPStart));       
  
  
    XML vq=xml.addChild("VIDEO_QUALITY");
    vq.setContent(str(VideoQuality));
    
    XML cf=xml.addChild("CLIENT_FULL");
    cf.setContent(str(ClientFull));
    XML cn=xml.addChild("CLIENT_COUNT");
    cn.setContent(str(ClientCount));
    
    
             
    saveXML(xml,"data\\param_file.xml");
    
  }
  
}