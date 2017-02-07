import netP5.*;
import oscP5.*;

import http.requests.*;

GlobalParameter _global;
OscP5 oscP5;

ArrayList<String> _client_record;

String _log="";


void setup(){
  size(400,400);
  frameRate(12);
  
  _global=new GlobalParameter();  
  oscP5=new OscP5(this,12000);

  _client_record=new ArrayList<String>();
  
}

void draw(){
   background(255,30,100);
   text("GLEN RECORD SERVER",20,20);
   text(_log,20,50);
   checkUpdate();
   checkEmptyClient();
      
}

void keyPressed(){
   switch(key){
      case 'r':
        sendReset(1);
        break;
      case 'a':
        sendResetAll();
        break;
   }
}


String[] listFileNames(String dir_){
  File file=new File(dir_);
  if(file.isDirectory()){
    String names[] = file.list();
    return names;
  }else{ // If it's not a directory
    return null;
  }
}

void checkUpdate(){
  String[] order_=listFileNames(_global.OrderFolder);
  if(order_==null){
    writeLog("Error folder! "+_global.OrderFolder);
    
    return;
  }
  if(order_.length>0){
    
    resetLog();
    
    
    String id=order_[0];
    writeLog("Get order: "+id);
    
    int pos=id.indexOf("_m");
    int end=id.lastIndexOf("_");
    if(pos<0 || end<=pos){
       writeLog("Illegal order: "+id);     
    }else{    
      String mid=id.substring(pos+2,end);
      writeLog("From: "+mid);
      _client_record.add(mid);
        
        
      combineVideo(order_[0]);
      uploadVideo(order_[0]);
      
    }
    File file=new File(_global.OrderFolder+order_[0]);
    file.delete();
    
    
  }
}

void checkEmptyClient(){
  if(_client_record.size()>_global.ClientFull) sendReset(_client_record.size()-_global.ClientFull);
}
void resetLog(){
   _log=""; 
}
void writeLog(String str){
   println(str);
   _log+=str+"\n";
}