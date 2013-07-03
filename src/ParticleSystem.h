#ifndef _PARTICLE_SYSTEM
#define _PARTICLE_SYSTEM

#include "ofMain.h"
//#include "ofxVec2f.h"
#include "ofVec2f.h"
#include "Particle.h"
#include <vector>

extern bool haveNextNextGaussian;
extern float nextNextGaussian;

extern float   nextGaussian();


class ParticleSystem {

	public:

		vector<Particle> particles;     // A dynamic array for all the particles
 
		ofVec2f origin;				// An origin point for where particles are birthed
		ofImage*  img;
		bool blnIsIpad;
		ParticleSystem();

		ParticleSystem(bool _blnIsIpad);
	
		void addParticle(ofVec2f l,ofImage* _img);
		
		bool dead();

		// add my own code for the cloud movement  2010-6-3
		int getSize();
		void add_force( ofVec2f vdir, float rate);
		void add_angleSpeed( float _angle, float rate);
		void set_angleSpeed( float _angle);
		void add_szSpeed( float _szspeed, float rate);
		void add_alphaSpeed(float _alphaspeed, float rate);

		void addParticle(ofImage* _img);
		void rendercloud();

	
  
};
#endif



