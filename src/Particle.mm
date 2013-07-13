#include "Particle.h"
#include "Globals.h"
 
 Particle::Particle(ofVec2f l, ofImage* aryimg_ , bool _blnIsIpad){

	acc.set(0,0);
	 if(_blnIsIpad){
	 vel.set(ofRandom(0.1,0.3), ofRandom(-.05,.1));
	 }
	 else{
		 vel.set(ofRandom(0.1,0.3), ofRandom(-.05,.1));
	 }
	loc = l;
	img = aryimg_;
	imageIndex = (int)ofRandom(0,4.4);
	szspeed = ofRandom(-1,1);
	 angles = ofRandom(-1,2);
	anglespeed = ofRandom(-0.05,0.05);
	 alphaSpeed = 0;

	 
	 blnIsIpad = _blnIsIpad;
	 if(!blnIsIpad){
		 sz=ofRandom(50,200);
	 }else
	 {
		 sz = ofRandom(80, 200);
	 }
		
	}

	

bool Particle::dead() {
	if (loc.x> ofGetWidth()|| loc.x<-300 ) {
		return 1;
	} 
	if(loc.y<0 || loc.y>ofGetHeight()){
		return 1;
	}
	if(!blnIsIpad){
		if(sz>220){
			return 1;
		}
	}
	else{
		if(sz>400){
			return 1;
		}
		
	}
	return 0;
}

void Particle::add_force(ofVec2f f){
    
    f.x = ofClamp(f.x, -0.1, 0.1);
    f.y = ofClamp(f.y, -0.02, 0.02);
	acc+=f;
}
void Particle::add_angleSpeed( float _angle){
	anglespeed+=_angle;

}
void Particle::set_angleSpeed( float _angle){
	anglespeed = _angle;

}
void Particle::add_szSpeed( float _szspeed){

	szspeed+= _szspeed;

}
void Particle::add_alphaSpeed( float _alphaSpeed){
	alphaSpeed += _alphaSpeed;
}
void Particle::updatecloud(){
	
	vel+=acc*scaleWidth;
	loc+=vel*scaleWidth;
	acc*=0;
	

	//if(loc.y<200 || loc.y>ofGetHeight()-200){
	//	vel.y *=-1;
	//	vel.x = ofRandom(0.1,0.8);

	//}
	
	angles+= anglespeed;
	sz+= szspeed;
	
	if(!blnIsIpad){
		if(sz>200){
			szspeed = ofRandom(-1,-0.1);
		}
		if (sz<100)
		{
			szspeed = ofRandom(0.1,1);
		}
	}
	else{
		if(sz>200){
			szspeed = ofRandom(-1,-0.1);
		}
		if (sz<100)
		{
			szspeed = ofRandom(0.1,1);
		}
		
	}
	
	


}
void Particle::rendercloud(){
	
	ofPushStyle();
	ofPushMatrix();
	ofTranslate(loc.x,loc.y);
	ofRotate(angles);
	
	if(!blnIsIpad){
		ofSetColor(255,255,255,(220-sz)*0.5+alphaSpeed);
	}
	else{
		ofSetColor(255,255,255,(600-sz)*0.1+alphaSpeed);
	}
	
	
	img[imageIndex].draw(-sz*scaleWidth/2,-sz*scaleWidth/2,sz*scaleWidth,sz*scaleWidth);
	ofPopMatrix();
	ofPopStyle();

}

void Particle::run(){

	updatecloud();
	rendercloud();
}


