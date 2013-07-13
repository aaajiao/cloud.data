#pragma once


#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ParticleSystem.h"
//#include "ofxALSoundPlayer.h"
//#include "ofxVec2f.h"
#include "Globals.h"

class testApp : public ofxiPhoneApp{
	
public:
	void setup();
	void update();
	void draw();
	
	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	void touchDoubleTap(int x, int y, int id);
	
	
	
	string strmessage;
	string strmessage1;
	string strmessage2;
	bool blnshowmessage;
	
	ofTexture texCloud;	
	ofImage* aryimgCloud;
	
	ParticleSystem pscloud;
	
	ofSoundPlayer synth;
	ofSoundPlayer sd9;
	ofSoundPlayer sd3;
	ofSoundPlayer sd4;
	
	int musiccounter9;
	int musiccounter3;
	int musiccounter4;
	
	

	ofImage imgfinger1;
	ofImage imgfinger2;
	ofImage imgfinger3;
	ofImage imgfinger1ip;
	ofImage imgfinger2ip;
	ofImage imgfinger3ip;
	bool    blnshowfinger;
	
	
	GLuint texture[1];
	ofImage texImg;
	
	bool bln1touch;
	bool bln2touch;
	bool bln3touch;
	
	int x1;
	int y1;
	int x2;
	int y2;
	int x3;
	int y3;
	float dist;
	
	int prex1;
	int prey1;
	int prex2;
	int prey2;
	int prex3;
	int prey3;
	
	float predist;

	ofVec2f point_red;
	
	//ofxVec2f redpoint1;
	//ofxVec2f redpoint2;
	//ofxVec2f redpoint3;

	ofImage imgInstruction;
	
	int touchcounter;
	int touchcounter2;
	
	bool blnIsIpad;
    
//    int ofGetWidth(){
//        return 320*scaleWidth;
//    }
//    int ofGetHeight(){
//        return 480*scaleHeight;
//    }
    ofPoint mouse(){
        
        float mousex = ofMap(mouseX,0,320*scaleWidth,0,320);
        float mousey = ofMap(mouseY, 0, 480*scaleHeight, 0,480);
        ofPoint p;
        p.set(mousex, mousey);
        return p;
    }
	
};
