#include "PSystem.h"

PSystem::PSystem(void)
{
}

PSystem::~PSystem(void)
{
}
PSystem::PSystem(ofVec3f _ps_loc, int _num, float _th, float _r, float _handrate){
	ps_loc = _ps_loc;
	th = _th;
	

	for(int i = 0;i<_num;i++){
		JParticle ptemp =  JParticle(ofVec3f(0,0,0),  ofVec3f(0,0,0),  ofVec3f(_ps_loc.x, _ps_loc.y, _ps_loc.z), ofRandom(1,30),i,ofRandom(0.1,_handrate), th);
		particles.push_back(ptemp);
	}
	r = _r;

}

void PSystem::sethandrate(float _handrate){
	for(int i = particles.size()-1; i>1;i--){
		JParticle prt =  particles[i];
		prt.sethandrate(ofRandom(0.1,_handrate));
	}
}


void PSystem::run(){
	update();
	for(int i = particles.size()-1; i>1;i--){
		JParticle* prt =  &particles[i];
	
		prt->run();
		prt->move( ofVec3f(ps_loc.x, ps_loc.y, ps_loc.z));
	} 
}

void PSystem::update(){
	// th += 0.002f; 
	ps_loc.x =  r*cos(th);
	ps_loc.y =  r*sin(th);
	ps_loc.z = 0 - r/2-10;
	ps_loc.x += ofRandom(-5.0f, 5.0f); 
	ps_loc.y += ofRandom(-10.0f,10.0f); 
	ps_loc.z += ofRandom(-10.0f,10.0f); 
}