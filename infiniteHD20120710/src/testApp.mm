#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	//ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	//ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	//ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	cout<<ofGetWidth()<<endl;
    cout<<ofGetHeight()<<endl;
    
    HDrate=1;
    
	if(ofGetWidth()>=768){
		blnIsIpad = true;
	}
	else{
		blnIsIpad = false;
        
        if (ofGetWidth()>=640) {
            HDrate =2;
        }
	}
	if(blnIsIpad){
		point_red = ofVec2f(40,1000);		// IPAD blue dot's position		***********************
		font.loadFont("frabk.ttf", 60);		// IPAD font size of the time	*********************
		
	}
	else{
		point_red = ofVec2f(20.0*HDrate,470.0*HDrate);	// IPHONE blue dot's position	***********************
		font.loadFont("frabk.ttf", 25*HDrate);		// IPHONE font size of the time	*********************
        
	}
	
	ofBackground(0, 0, 0);
	
	bgmusic.loadSound("bgmusic.caf");
    bgmusic.setLoop(true);
	bgmusic.play();
	
	
	loc = ofVec3f(30,0,60);
	angle = 0;
	section =60;
	
	j1 = JellyFish(0);
	j1.initial();
	
	
	if( XML.loadFile(ofxiPhoneGetDocumentsDirectory() + "TimeSettings.xml") ){
		message = "mySettings.xml loaded from documents folder!";
	}else if( XML.loadFile("TimeSettings.xml") ){
		message = "mySettings.xml loaded from data folder!";
	}else{
		message = "unable to load mySettings.xml check data/ folder";
	}
	
	hour = XML.getValue("TIME:HOUR",0);
	minute = XML.getValue("TIME:MINUTE",0);
	second = XML.getValue("TIME:SECOND",0);
	year = XML.getValue("TIME:YEAR", 0);
	month = XML.getValue("TIME:MONTH", 0);
	day = XML.getValue("TIME:DAY", 0);
	
	
	curhour =(int)ofGetHours();
	
	oriyear = ofGetYear();
	orimonth = ofGetMonth();
	oriday = ofGetDay();
	orihour = ofGetHours();
	orimin = ofGetMinutes();
	orisecond =ofGetSeconds();
	
	alltime=0.0;
	
	
	
	
	
	JellyScale = 0.5;
	blnJellyGrow = true;
	
	touchcounter = 0;
	touchcounter2 =0;
	x1 = -1;
	y1 = -1;
	x2 = -1;
	y2 = -1;
	prex1 = -1;
	prey1 = -1;
	prex2 = -1;
	prey2 = -1;
	
	bln1touch = false;
	bln2touch = false;
	bln3touch = false;
	
	
	blnshowmessage= false;
	blnshowfinger = false;
	
}

int testApp::getmonthday(int _month){
	switch (_month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			break;
			
		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
			break;
		default:
			return 28;
			break;
	}
}

//--------------------------------------------------------------
void testApp::update(){
	
	angle+=1;
	
	if(j1.scalevalueFinger==1){
		
		if (blnJellyGrow) {
			JellyScale+=0.0005;
			if (JellyScale>=1.5) {
				blnJellyGrow = false;
			}
		}
		else {
			JellyScale-=0.0006;
			if (JellyScale<=0.5) {
				blnJellyGrow = true;
			}
		}
		
		j1.setScale(JellyScale);
	}
	
	if (ofRandom(0,200)<1) {
		if(ofRandom(0,4)<1){
			j1.blnbeginswim = true;
		}
	}
	
	if(touchcounter>=0){
		touchcounter--;
	}
	if(touchcounter2>=0){
		touchcounter2--;
	}
	
	
	
	
	if(hour ==200){
		alltime =(ofGetYear()-oriyear)*365*24*3600 + (ofGetMonth()- orimonth)*getmonthday(orimonth)*24*3600+ (ofGetDay()-oriday)*24*3600+
		(ofGetHours()-orihour)*60.*60.+ (ofGetMinutes()-orimin)*60.+ofGetSeconds()-orisecond;
		
	}
	else{
		alltime =(ofGetYear()-year)*365*24*3600 + (ofGetMonth()- month)*getmonthday(month)*24*3600+ (ofGetDay()-day)*24*3600+
		(ofGetHours()-hour)*60.*60.+ (ofGetMinutes()-minute)*60.+ofGetSeconds()-second;
	}
	

}

//--------------------------------------------------------------
void testApp::draw(){
	
	glShadeModel(GL_SMOOTH);
	glDisable(GL_DEPTH_TEST);
    
    
//----- DEBUG -----  -----  -----  -----
   // ofPushStyle();
  //  ofSetColor(255, 0, 0);
   // ofFill();
   //// ofRect(100, 100, 200, 200);
   // ofPopStyle();
//-----   --------------------   ----- -
	
	if(blnshowfinger){
		
		int hourtime = (int)alltime/3600;
		int mintime = ((int)alltime%3600)/60;
		int secondtime = (int)alltime%60;
		
		ofPushStyle();
		ofSetColor(255, 255, 255);
		if(!blnIsIpad){
            font.drawString(ofToString(hourtime), 145*HDrate, 100*HDrate);  // IPHONE time position *****************
            font.drawString(". .", 147*HDrate, 150*HDrate);
            font.drawString(ofToString(mintime), 145*HDrate, 223*HDrate);
            font.drawString(". .", 147*HDrate, 280*HDrate);
            font.drawString(ofToString(secondtime), 145*HDrate, 350*HDrate);
		}
		else {
			font.drawString(ofToString(hourtime), 350, 250);	// IPAD time position *****************
			font.drawString(". .", 355, 350);
			font.drawString(ofToString(mintime), 350, 520);
			font.drawString(". .", 355, 650);
			font.drawString(ofToString(secondtime), 350, 800);
		}
		
		ofPopStyle();
		
		
	}
	if(!blnshowfinger){
		ofEnableAlphaBlending();	
		ofNoFill();
		
		j1.update();
		j1.render();
		ofDisableAlphaBlending();
		
		//cout<<ofGetFrameRate()<<endl;
		
		
		
		if (bln1touch ==true) {
			if (touchcounter<0 && bln2touch ==false) {
				message ="one finger touched";
				if (j1.scalevalueFinger >1) {
					j1.lx+= (x1-prex1)*0.5;
					j1.ly+= (y1-prey1)*0.5;
				}
				
			}
			else if(bln2touch ==true){
				
				if (touchcounter2<0 && bln3touch == false) {
					dist = ofDist(x1, y1,x2, y2);
					message = "two fingers touched";
					
					if (ABS(predist -dist)<100) {
						message =" open or close 2 fingers";
						j1.scalevalueFinger += (dist-predist)*0.03;
						if(j1.scalevalueFinger<1){
							j1.scalevalueFinger =1;
						}
						//j1.scalevalue1 = ofClamp(j1.scalevalue1, 1, 300);
						
					}
					
				}
			}
		}
		
		prex1 = x1;
		prey1 = y1;
		prex2 = x2;
		prey2 = y2;
		prex3 = x3;
		prey3 = y3;
		predist = dist;
	}
	
	ofPushStyle();
	ofFill();
	ofSetColor(0,0,255);
    if(!blnIsIpad){
		ofEllipse(point_red.x,point_red.y,6*HDrate,6*HDrate);
	}
	else{
		ofEllipse(point_red.x,point_red.y,6,6);
	}
	ofNoFill();
	ofPopStyle();
	
	if(blnshowmessage){
		
		ofPushStyle();
		ofSetColor(255,255,255);
		ofDrawBitmapString(ofToString(ofGetFrameRate()),10,10);	
		
		ofDrawBitmapString("show original time :",10,20);
		ofDrawBitmapString(   ofToString(year)+"/"+ofToString(month)+"/"+ ofToString(day)+"/"+ofToString(hour)+"/"+ofToString(minute)+"/"+ofToString(second),10,30);
		ofDrawBitmapString("show the time :",10,40);
		ofDrawBitmapString( ofToString(ofGetYear())+"/"+ofToString(ofGetMonth())+"/"+ofToString(ofGetDay())+ofToString(ofGetHours())+"/"+ofToString(ofGetMinutes())+"/"+ofToString(ofGetSeconds()),10,50);
		
		ofDrawBitmapString(ofToString(alltime),10,70);
		//font.drawString(ofToString(predist-dist),10,90);
		ofPopStyle();
	}
	
	
}

//--------------------------------------------------------------
void testApp::exit(){
	
	if(hour==200){
		XML.setValue("TIME:YEAR",oriyear);
		XML.setValue("TIME:MONTH",orimonth);
		XML.setValue("TIME:DAY",oriday);
		XML.setValue("TIME:HOUR",orihour);
		XML.setValue("TIME:MINUTE",orimin);
		XML.setValue("TIME:SECOND",orisecond);
		XML.saveFile(ofxiPhoneGetDocumentsDirectory()+"TimeSettings.xml");
		XML.saveFile("TimeSettings.xml");
		message = "xml file saved succussfully";
	}

}

//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){
	if(id==0){
		
		touchcounter = 2;		
		//strmessage= "Down 1 point"+ofToString(x)+"  "+ofToString(y);	
		
	}
	if(id==1){
		touchcounter2 = 1;
		//strmessage = "Down 2 point";
	}
	if(id ==2){
		bln3touch = true;
	}
	

}

//--------------------------------------------------------------
void testApp::touchMoved(int x, int y, int id){
	
	if(id ==0){
		
		bln1touch = true;
		x1 = x;
		y1 = y;
		
		
	}
	if(id ==1){
		bln2touch = true;
		x2 = x;
		y2 = y;
		
		
	}
	if(id ==2){
		
		//bln3touch = true;
		x3 = x;
		y3 = y;
	}
}

//--------------------------------------------------------------
void testApp::touchUp(int x, int y, int id){

	if(id==0){
		
		
		if(ofDist((float)x, (float)y, point_red.x,point_red.y)<30){
			blnshowfinger = !blnshowfinger;
		}
		if(ofDist((float)x, (float)y, 30,30)<30){
			blnshowmessage = !blnshowmessage;
		}
		
		
		bln1touch = false;
		bln2touch = false;
		bln3touch = false;
		
	}
	if(id ==1){
		bln2touch = false;
		bln3touch = false;
	}
	if(id ==2){
		bln3touch = false;
		bln2touch = false;
		predist =0;
		dist = 0;
		
	}
}

//--------------------------------------------------------------
//void testApp::touchDoubleTap(ofTouchEventArgs &touch){
//
//}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
//void testApp::touchCancelled(ofTouchEventArgs& args){
//
//}

