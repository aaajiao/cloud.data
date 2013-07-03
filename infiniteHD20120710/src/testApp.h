#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
//#include "ofxVectorMath.h"
#include "JellyFish.h"

#include "ofxXmlSettings.h"

#include "ofxOpenALSoundPlayer.h"

class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	int getmonthday(int _month);
	
	ofVec3f loc;
	int section;
	float angle;
	
	JellyFish j1;
	
	ofxXmlSettings XML;
	int hour;
	int minute;
	int second;
	int year;
	int month;
	int day;
	int monthday;
	
	int oriyear;
	int orimonth;
	int oriday;
	
	int orihour;
	int orimin;
	int orisecond;
	
	int curhour;
	int curmin;
	int cursecond;
	
	double alltime;
	
	string message;
	
	float JellyScale;
	bool blnJellyGrow;
	
	//===========touch event
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
	int touchcounter;
	int touchcounter2;
	
	ofTrueTypeFont  font;
	
	
	bool blnshowmessage;
	bool blnshowfinger;
	//ofxVec2f point_red;
    ofVec2f point_red;
	bool blnIsIpad;
	
	
	ofxOpenALSoundPlayer bgmusic;
    
    float HDrate;

};


