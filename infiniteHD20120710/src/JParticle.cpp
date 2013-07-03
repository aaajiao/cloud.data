#include "JParticle.h"

JParticle::JParticle(void)
{
}

JParticle::~JParticle(void)
{
}

JParticle::JParticle(ofVec3f a, ofVec3f v, ofVec3f l, float ms_,  float counter_ , float _handrate, float _th){
	acc = a;
	vel = v;
	loc = l;
	ms = ms_;
	counter = counter_;
	lengthVar = ofRandom(0,10);

	handrate = _handrate;
	angles = _th;
}


void JParticle::sethandrate(float _hand){
	handrate = _hand;
}
void JParticle::run(){

	vel+=acc;	
	loc+=vel;  
	acc =  ofVec3f(0,0,0);

	ofSetColor(255,255,255,20);
	tempz = ms*handrate;
	tempy = tempz*1.5*sin(angles);
	float  tempx =tempz*1.5*cos(angles);
	ofSetColor(255,255,255,tempz*5);

	ofSetLineWidth(2);
	ofPushMatrix();

	const GLfloat linesvertex[]={
		loc.x+tempx, loc.y+tempy, loc.z-tempz,
		 loc.x+2+tempx, loc.y+2+tempy, loc.z-tempz+2
	};
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glVertexPointer(3, GL_FLOAT, 0, linesvertex);
	glDrawArrays(GL_LINE_STRIP, 0,2);
	
	/*
	glBegin(GL_LINES);
	glVertex3f(loc.x+tempx, loc.y+tempy, loc.z-tempz);
	glVertex3f( loc.x+2+tempx, loc.y+2+tempy, loc.z-tempz+2);
	glEnd();
	 */
	ofPopMatrix(); 


}
void JParticle::move(ofVec3f target){
	acc+=(steer(target));
}
ofVec3f JParticle::getLocation(){
	return loc;
}
ofVec3f JParticle::steer(ofVec3f target){
	ofVec3f steer; 
	ofVec3f desired = target-loc; 
	float d = sqrt(desired.x*desired.x+desired.y*desired.y+ desired.z*desired.z);
	desired.normalize(); 
	desired*=2.5f; 
	steer = desired-vel; 
	steer.limit(1.0f); 
	steer/=ms; 
	return steer; 

}
