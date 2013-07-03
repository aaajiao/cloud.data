#include "testApp.h"
#include "Globals.h"
//--------------------------------------------------------------
void testApp::setup(){	
	
	
	ofxRegisterMultitouch(this);
	ofxAccelerometer.setup();
	ofxiPhoneAlerts.addListener(this);	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	cout<<ofGetWidth()<<endl;
	cout<<ofGetHeight()<<endl;
	
	if(ofGetWidth()>1000){
		blnIsIpad = true;
	}
	else{
		blnIsIpad = false;
	}
	
	ofSetFrameRate(60);
	
//	synth.loadLoopingSound("music/6.caf");
//	sd9.loadSound("music/9.caf");
//	sd3.loadSound("music/3.caf");
//	sd4.loadSound("music/4.caf");
//	
//	synth.play();
		
	aryimgCloud = new ofImage[5];	
	
	aryimgCloud[0].loadImage("images/A0000.png");
	aryimgCloud[1].loadImage("images/A0001.png");
	aryimgCloud[2].loadImage("images/A0002.png");
	aryimgCloud[3].loadImage("images/A0003.png");
	aryimgCloud[4].loadImage("images/A0004.png");
	
	imgfinger1.loadImage("finger/f1.png");
	imgfinger2.loadImage("finger/f2.png");
	imgfinger3.loadImage("finger/f3.png");
	imgfinger1ip.loadImage("finger/f1_ip.png");
	imgfinger2ip.loadImage("finger/f2_ip.png");
	imgfinger3ip.loadImage("finger/f3_ip.png");
	
	
	blnshowfinger = false;
	
		
		
	pscloud = ParticleSystem(blnIsIpad);	
	
	strmessage= "";
	blnshowmessage = false;
	
	
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
	
	if(blnIsIpad){
		point_red = ofVec2f(1000,720);
	}
	else{
		point_red = ofVec2f(450.0,300.0);
		
		
	}
	
	musiccounter9=30;
	
	bln1touch = false;
	bln2touch = false;
	bln3touch = false;
	
	// redpoint1= ofxVec2f(80+imgfinger1.width/3+20,40+imgfinger1.height/6);
	// redpoint2= ofxVec2f(80+imgfinger1.width/3+20,50+imgfinger1.height/6+imgfinger1.height/3);
	// redpoint3= ofxVec2f(80+imgfinger1.width/3+20,60+imgfinger1.height/6+imgfinger1.height*2/3);
}

//--------------------------------------------------------------
void testApp::update(){
	
	
	if(blnIsIpad){
		if (pscloud.getSize()<100)
		{
			
				pscloud.addParticle(aryimgCloud);
			
		}
		
	}
	else{
		if (pscloud.getSize()<50)
		{
			
				pscloud.addParticle(aryimgCloud);
			
		}
		
	}
		
	if(touchcounter>=0){
		touchcounter--;
	}
	if(touchcounter2>=0){
		touchcounter2--;
	}
	
	 
	
}

//--------------------------------------------------------------
void testApp::draw(){	
//
	//glEnable(GL_DEPTH_TEST);
	//glDepthFunc(GL_LEQUAL);
	glShadeModel(GL_SMOOTH);
	glEnable(GL_TEXTURE_2D);
	//glBindTexture(GL_TEXTURE_2D,texture[0]);
    
   // ofScale(scaleWidth,1);
    
   
	
    ofBackground(0, 0, 0);
	
    
	if(blnshowfinger){
		ofEnableAlphaBlending();
		if(!blnIsIpad){
			imgfinger1ip.draw(30,ofGetHeight()/2-imgfinger1ip.height/2,imgfinger1ip.width,imgfinger1ip.height);
			imgfinger2ip.draw(30+imgfinger1ip.width/2,ofGetHeight()/2-imgfinger1ip.height/2, imgfinger1ip.width,imgfinger1ip.height);
			imgfinger3ip.draw(30+imgfinger1ip.width,ofGetHeight()/2-imgfinger1ip.height/2,imgfinger1ip.width,imgfinger1ip.height);
		}
		else{
			imgfinger1.draw(60,ofGetHeight()/2-imgfinger1.height/2,imgfinger1.width,imgfinger1.height);
			imgfinger2.draw(70+imgfinger1.width/2,ofGetHeight()/2-imgfinger1.height/2, imgfinger2.width,imgfinger2.height);
			imgfinger3.draw(80+imgfinger1.width,ofGetHeight()/2-imgfinger1.height/2-25,imgfinger3.width,imgfinger3.height);
			
		}
		ofDisableAlphaBlending();	
		
	}
	else{
	
	ofEnableAlphaBlending();
	pscloud.rendercloud();
	ofDisableAlphaBlending();	
		
	}
		
	
		
	if(!blnshowfinger){
	if(bln1touch == true){
		if(touchcounter <0 && bln2touch == false){	
			if(blnIsIpad){
			if(ABS(x1-prex1)<200){
			pscloud.add_force(ofVec2f((x1-prex1)*0.05,(y1-prey1)*0.01), 2.0);
			}
			}
			else{
				if(ABS(x1-prex1)<100){
					pscloud.add_force(ofVec2f((x1-prex1)*0.03,(y1-prey1)*0.01), 2.0);
				}
			}
			
			if(musiccounter9 ==0){
				//sd9.play();
				musiccounter9 =30;
			}
			strmessage = "touchMove 1 point"+ofToString(x1)+"  "+ofToString(y1);	
		}
		else if(bln2touch == true){
			if(touchcounter2<0 && bln3touch == false){
			
				dist = ofDist(x1,y1,x2,y2);
				if(ABS(predist-dist)<2){
				
					pscloud.add_angleSpeed((x2-prex2)*0.005, 3.0);
				}
				else{
					pscloud.add_szSpeed((dist-predist)*0.1, 3.0);
				}
				
				if(musiccounter3 ==0){
					//sd3.play();
					musiccounter3 =150;
				}
				strmessage1 = "touchMove 2 point x1="+ofToString(x1)+" y1="+ofToString(y1)+" x2="+ofToString(x2)+" y2="+ofToString(y2);
			}
			else if(bln3touch = true){
				
					
					if(blnIsIpad){
						if(ABS(x3-prex3)<200){
				pscloud.add_alphaSpeed((x3-prex3)*-0.1, 10);
					}
					}
					else{
						if(ABS(x3-prex3)<100){
						pscloud.add_alphaSpeed((x3-prex3)*-0.5, 10);
						}
					}
				
				if(musiccounter4 ==0){
					//sd4.play();
					musiccounter4 =150;
				}
				
				
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
	
	
	
	ofPushStyle();
	ofFill();
	ofSetColor(255,0,0);
	if(!blnIsIpad){
	ofEllipse(point_red.x,point_red.y,6,6);
	}
	else{
		ofEllipse(point_red.x,point_red.y,12,12);
	}
	ofNoFill();
	ofPopStyle();
	
	
	
	
	if(false){
	ofDrawBitmapString(strmessage,10,10);
	ofDrawBitmapString(strmessage1, 10, 20);
	ofDrawBitmapString(strmessage2, 10, 30);
	ofDrawBitmapString("touchcounter "+ofToString(touchcounter), 10, 40);
	ofDrawBitmapString("counter2"+ofToString(touchcounter2),10,50);
	}
	strmessage2 = "bln3touch"+ ofToString(bln3touch)+"  bln2touch "+ofToString(bln2touch);
	
	
	
	
	musiccounter9--;
	musiccounter9 = ofClamp(musiccounter9, 0, 30);
	musiccounter3--;
	musiccounter3 = ofClamp(musiccounter3, 0, 150);
	musiccounter4--;
	musiccounter4 =  ofClamp(musiccounter4, 0, 150);
     
    /*
    ofSetColor(255, 255, 255);
    ofCircle(mouse().x, mouse().y, 20);
    */

}


//--------------------------------------------------------------
void testApp::touchDown(int x, int y, int id){

	if(id==0){
		
		touchcounter = 2;		
		strmessage= "Down 1 point"+ofToString(x)+"  "+ofToString(y);	
		
	}
	if(id==1){
		touchcounter2 = 1;
		strmessage = "Down 2 point";
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
		if(pscloud.getSize()<200){
		pscloud.addParticle(ofVec2f(x,y),aryimgCloud);		
		}
			
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

	}

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(int x, int y, int id){
	

}
