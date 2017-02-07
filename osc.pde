void sendReset(int num_){
   
   for(int i=0;i<num_;++i){
     
     String mid=_client_record.get(0);
     writeLog("Send Reset to "+mid);
     
     NetAddress loc_=new NetAddress(_global.LocalIP+mid,12000);
     OscMessage message_=new OscMessage("/reset");
     oscP5.send(message_,loc_);
     
     _client_record.remove(0);
   }
}

void sendResetAll(){
    
    writeLog("Send reset to all!");
     
    for(int i=0;i<_global.ClientCount;++i){
         
     NetAddress loc_=new NetAddress(_global.LocalIP+nf(_global.IPStart+i),12000);
     OscMessage message_=new OscMessage("/reset");
     oscP5.send(message_,loc_);
     
   }
}