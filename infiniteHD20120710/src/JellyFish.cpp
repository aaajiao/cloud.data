#include "JellyFish.h"

JellyFish::JellyFish(void)
{
	
}

JellyFish::~JellyFish(void)
{
}

JellyFish::JellyFish(int _i){
	ID = _i;
	
	blnchangesale = true;
	blnbeginswim = false;

	scalevalue=0.5;
	scalevalue1=1;
	scalespeed = 0.5;
	section =50;//80;
	changespeed =0.3;
	changebazier = 0.005 ;
	baziernum = 0.1;
	numSystems =80;// 100;

	ps = new PSystem[numSystems];

	theta =0.0;
	
	scalevalueFinger=1;


}

void JellyFish::setScale(float _scale){
	scalevalue = _scale;
}
float JellyFish::getScale(){
	return scalevalue;
}

  void JellyFish::initial(){
    inx =0;
    iny = 0;
    centerLoc = ofVec3f(ofGetWidth()/2,ofGetHeight()/2,0);
    r = 22.0f;
    amplitude= r;

  float handrate = ofRandom(0.3,0.7);
    for(int i =0;i<numSystems;i++){
      x = r*cos(theta);
      y = r*sin(theta);
      z = 1;
      x+= inx;
      y+= iny;
      ps[i] =  PSystem( ofVec3f(x ,y,z), 20,theta, r, handrate);
      theta += 2*PI/numSystems;
      //println(degrees(theta));
    }
    //=============================
    loc = ofVec3f(30,0,60);
    angle = 0;

    //===================
    lx = ofRandom(100,ofGetWidth()-100);
    ly= ofRandom(100, ofGetHeight()-100);
    lz = ofRandom(-20,10);
    vx = ofRandom(0.5,0.8);
    vy = ofRandom(-0.8,0.8);
    rotangle =0;
    rotanglespeed = 0.002;//ofRandom(0.005,0.01);

  
  }


  void JellyFish::update(){
	  
	  if (ofGetFrameNum()%2000==0) {
		  vx *=-1;// ofRandom(-0.8,0.8);
		  vy *=-1;// ofRandom(-0.8,0.8);
	  }
	  
    if(blnbeginswim){
    if(blnchangesale){
      scalevalue1+=(0.7-scalevalue1)/3;
      lx+=ofRandom(3,5)*sin(rotangle);
      ly+=ofRandom(-3,-2);
      
		
      if(scalevalue1<=0.75){
        scalevalue1 = 0.7;
        blnchangesale = false;
    }
		 
    }
    if(!blnchangesale){
      scalevalue1 +=0.01;
      if(scalevalue1>=1){
        scalevalue1 = 1;
        blnchangesale = true;
        blnbeginswim = false;
      }
    }
      
    }
	  
	  loc.x+=changespeed;
    loc.y+= changespeed;
    if(loc.x>28 || loc.x <10){
      changespeed*=-1;
    }


    baziernum+= changebazier;
    if(baziernum>0.15 || baziernum < -0.2){
      changebazier*=-1;
    }

   angle+=0.01;
   vx+= ax;
   vy+=ay;
   
   vx = ofClamp(vx,-0.8,0.8);
   vy = ofClamp(vx,-0.8,0.8);
	  
	  
   ax =0;
   ay =0;
  
	  //*************************************
	  //!!!!!!!!!change 1.2 to quick or slow.
	  //*************************************
	  
	  if (scalevalueFinger ==1) {
		  lx+=vx*0.5;
		  ly+=vy*0.5;
	  }
	  
   
	  
	  
   if(lx>ofGetWidth()+30 && vx>0){
     lx =-30;
     vx = ofRandom(0.3,0.8);
     float handrate = ofRandom(0.2,0.8);
    for(int i =0;i<numSystems;i++){
ps[i].sethandrate(handrate);
    }
   }
 if(lx<-30 && vx<0){
   lx =ofGetWidth()+30;
    vy = ofRandom(-0.8,-0.3);
     float handrate = ofRandom(0.2,0.8);
   for(int i =0;i<numSystems;i++){
       ps[i].sethandrate(handrate);
   }
	 
	 rotanglespeed= ofRandom(0.002,0.006);
 }
 if(ly>ofGetHeight()+30&& vy>0 ){
	 ly =-20;
	 vy = ofRandom(0.5,0.8);
     float handrate = ofRandom(0.2,0.8);
    for(int i =0;i<numSystems;i++){
       ps[i].sethandrate(handrate);
   }
	 rotanglespeed= ofRandom(0.002,0.006);
 }
 if(ly<-30 && vy <0 ){
	 ly =ofGetHeight()+30;
	 vy =ofRandom(-0.8,-0.5);
     float handrate = ofRandom(0.2,0.8);
	 for(int i =0;i<numSystems;i++){
	   ps[i].sethandrate(handrate);
    }
	 rotanglespeed= ofRandom(0.002,0.006);
 }
 
 
 rotangle+=rotanglespeed;
 if(rotangle> PI*2) rotangle = 0;
 
  }






  void JellyFish::render(){
  

    ofPushMatrix();
	  
	  
   
	  ofTranslate(lx,ly,lz);
	  ofRotateX(ofRadToDeg(rotangle));
	  ofRotateZ(ofRadToDeg(rotangle));
	  
	  ofScale(scalevalue,scalevalue,scalevalue);
	  ofScale(scalevalueFinger, scalevalueFinger,scalevalueFinger);
  
	  /*
	  float tempi = 1/(scalevalue*scalevalue);
	  int k = (int)tempi;
	  k = ofClamp(k,1,100);	  
    
    for(int i = 0.0; i < numSystems; i+=k) 
    { 
      ps[i].run(); 
    }  
	   */

	  for (int i=0; i<numSystems; i++) {
		  ps[i].run();
	  }
	

    ofPushMatrix();
    ofRotateX(-90); 
    ofTranslate(0,-30);
    
    
    temp = loc.x*.1;
    for(int i = 0;i<section;i++){
      ofRotateY(400/section);  // why is 400?
	//	ofRotateY(360*i/section);
      ofSetColor(255,255,255,25);
	 ofSetLineWidth(3);
	  ofBezier(loc.x,loc.z, loc.x -loc.x*baziernum,loc.z-loc.z*baziernum,loc.x-loc.x/3,loc.z-loc.z/3,10,50 );
	  ofSetColor(255,255,255,15);
	  ofSetLineWidth(2);
	  ofBezier(0,0, loc.x*1.1-loc.x*baziernum, loc.y*1.1-loc.y*baziernum, loc.x*0.9,loc.z,loc.x-6,loc.z );
		
		
		ofSetColor(255,255,255,25);
		ofSetLineWidth(3);
		ofBezier(0,8, 25-20*baziernum, 8-8*baziernum, 22,50,20,50);
		
		ofSetColor(255,255,255,20);
		ofSetLineWidth(2);
		ofBezier(0,15, 5, 15, 15,25,0,35);
	
    }
	  for(int i = 0;i<4;i++){
		  ofRotateY(100);
		  ofSetColor(255,255,255,80);
		  ofSetLineWidth(3);
		  ofBezier(0,8, 25-20*baziernum, 8-8*baziernum, 22,50,20,50);
		  
		  
	  }
   

    ofPopMatrix();
ofPopMatrix();


  }