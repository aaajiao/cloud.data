#pragma once

#include "ofMain.h"
#include "PSystem.h"
//#include "ofxVectorMath.h"


class JellyFish
{
public:
	JellyFish(void);
	~JellyFish(void);
	JellyFish(int _i);

	 void initial();
	 void update();
	  void render();
	void setScale(float _scale);
	float getScale();



	float inx, iny,inz;
	ofVec3f centerLoc;
	int numSystems ;
	PSystem* ps;  
	float theta;
	float r;
	float amplitude;
	float x, y,z;

	float rotx, roty;

	float jx, jy, jz;
	float jxSpeed, jySpeed, jzSpeed, jxRot, jyRot, jzRot;
	int zoom;

	//=================================
	ofVec3f loc;
	int section ;
	float angle;
	float changespeed ;

	float changebazier  ;
	float baziernum ;
	float temp;


	//==============================


	float lx;
	float ly;
	float lz;
	float vx;
	float vy;
	float ax;
	float ay;
	float rotangle;
	float rotanglespeed;
	int ID;
	float scalevalue;
	
	float scalespeed ;
	
	float scalevalue1;

	float scalevalueFinger;

	bool blnchangesale ;
	bool blnbeginswim ;
};
