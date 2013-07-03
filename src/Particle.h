#ifndef _PARTICLE
#define _PARTICLE

#include "ofMain.h"
#define OF_ADDON_USING_OFXVECTORMATH
//#include "ofAddons.h"
#include "ofVec2f.h"

class Particle {

	public:
	
		ofVec2f loc;
		ofVec2f vel;
		ofVec2f acc;
		float r;
		float timer;
		
		//new attribute for the cloud  2010 6 
		ofImage* img;
		float  szspeed;
		float  sz;
		float  angles;
		float  anglespeed;
		int imageIndex;
		float alphaSpeed;
		bool blnIsIpad;
	
	
		bool dead();
		Particle(ofVec2f l, ofImage* aryimg_, bool _blnIsPad);
		
		void add_force(ofVec2f f);
		void add_angleSpeed( float _angle);
		void set_angleSpeed( float _angle);
		void add_szSpeed( float _szspeed);
		void add_alphaSpeed( float _alphaSpeed);
		void updatecloud();
		void rendercloud();
		void run();
	
	
		

};
#endif


