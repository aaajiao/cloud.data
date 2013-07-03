#pragma once

#include "ofMain.h"
//#include "ofxVectorMath.h"
class JParticle
{
public:
	JParticle(void);
	~JParticle(void);
	JParticle(ofVec3f a, ofVec3f v, ofVec3f l, float ms_,  float counter_ , float _handrate, float _th);


	void sethandrate(float _hand);
	void run();

	void move(ofVec3f target);
	ofVec3f getLocation();
	ofVec3f steer(ofVec3f target);

	ofVec3f loc;
	ofVec3f vel;
	ofVec3f acc;
	float ms;
	float counter;
	float lengthVar;
	float handrate;
	float tempz;
	float tempy;
	float angles;

};
