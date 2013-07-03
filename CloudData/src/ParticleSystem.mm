#include "ParticleSystem.h"


ParticleSystem::ParticleSystem() {
	
	
}

ParticleSystem::ParticleSystem(bool _blnIsIpad){
	blnIsIpad = _blnIsIpad;
}


bool ParticleSystem::dead() {
	if (particles.empty()) {
		return 1;
	} else {
		return 0;
	}
	
}




int ParticleSystem::getSize(){
	
	return particles.size();
}
void ParticleSystem::add_force( ofVec2f vdir, float rate){
	for(int i=particles.size()-1;i>=0;i--){
		if(ofRandom(0,10)<rate){
			particles[i].add_force(vdir);

		}
	}

}
void ParticleSystem::add_angleSpeed( float _angle, float rate){
	for(int i=particles.size()-1;i>=0;i--){
		if(ofRandom(0,10)<rate){
			particles[i].add_angleSpeed(_angle);

		}
	}

}
void ParticleSystem::set_angleSpeed( float _angle){
	for(int i=particles.size()-1;i>=0;i--){
		
			particles[i].set_angleSpeed(_angle);

	}
}
void ParticleSystem::add_szSpeed( float _szspeed, float rate){
	for(int i=particles.size()-1;i>=0;i--){
		if(ofRandom(0,10)<rate){
			particles[i].add_szSpeed(_szspeed);

		}
	}
}

void ParticleSystem:: add_alphaSpeed(float _alphaSpeed, float rate){
	for(int i=particles.size()-1;i>=0;i--){
		if(ofRandom(0,10)<rate){
			particles[i].add_alphaSpeed( _alphaSpeed);
			
		}
	}
	
}

void ParticleSystem::addParticle(ofImage* _img){

 
	ofVec2f vtemp;
	vtemp.set(origin);
	if(blnIsIpad){
	vtemp+= ofVec2f(ofRandom(-200,0),nextGaussian()*30+ofGetHeight()/2);
	}
	else{
		vtemp+= ofVec2f(ofRandom(-100,0),nextGaussian()*5+ofGetHeight()/2);
	}
	Particle p(vtemp,_img,blnIsIpad);
	particles.push_back(p);
	
	

}

void ParticleSystem::addParticle(ofVec2f l,ofImage* _img){
			Particle p(l,_img,blnIsIpad);
			particles.push_back(p);
}



void ParticleSystem::rendercloud() {
	for (int i = 0; i < particles.size(); i++) {
		particles[i].run();
	}
	for (int i = particles.size()-1; i >= 0; i--) {
		if (particles[i].dead()) {
			particles.erase(particles.begin() + i);
		}
	}
}


bool haveNextNextGaussian;
float nextNextGaussian;

float   nextGaussian()   { 
	if   (haveNextNextGaussian)   { 
		haveNextNextGaussian   =   false; 
		return   nextNextGaussian; 
	}   else   { 
		double   v1,   v2,   s; 
		do   {   
			v1   =   2   *   ofRandomf()   -   1;       //   between   -1.0   and   1.0 
			v2   =   2   *   ofRandomf()   -   1;       //   between   -1.0   and   1.0 
			s   =   v1   *   v1   +   v2   *   v2; 
		}   while   (s   >=   1   ||   s   ==   0); 
		double   multiplier   =   sqrt(-2   *  log(s)/s); 
		nextNextGaussian   =   v2   *   multiplier; 
		haveNextNextGaussian   =   true; 
		return   float(v1   *   multiplier); 
	} 
} 





