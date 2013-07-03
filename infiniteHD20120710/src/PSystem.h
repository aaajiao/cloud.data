#pragma once

#include "ofMain.h"
//#include "ofxVectorMath.h"
#include "JParticle.h"

class PSystem
{
public:
	PSystem(void);
	~PSystem(void);

 PSystem(ofVec3f _ps_loc, int _num, float _th, float _r, float _handrate);
	 void sethandrate(float _handrate);
	 void run();
	 void update();


	float th;
	ofVec3f ps_loc;
	vector<JParticle>  particles;
	float zP;
	float r;
};
