//
//  Globals.h
//  emptyExample
//
//  Created by kyriacos kousoulides on 15/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef emptyExample_Globals_h
#define emptyExample_Globals_h

extern BOOL isRetina,isiPad,iphone5;  
extern float scaleWidth,scaleHeight;



class UofImage : public ofImage{
public:
    
    bool loadImage(string url){
        
        string temp = url;
        
        if (iphone5) {
            url.insert(url.size()-4,"_i5");////comment this out if you want to load same images for iphone4 and iphone5
            ofImage::loadImage(url);
            
        }else{
            if(isiPad&&isRetina){
                url.insert(url.size()-4,"_hd");
                ofImage::loadImage(url);
            }
            if(!isiPad&&!isRetina){
                url.insert(url.size()-4,"_3g");
                ofImage::loadImage(url);
            }
            if(isiPad&&!isRetina){
    ///uncomment [url.insert(url.size()-4,"_ip");] if you want to include same images for ipad2(nonretina ipad) and iphone4 (recomented)
                
                url.insert(url.size()-4,"_ip");
                
                ofImage::loadImage(url);
                
            }
            if(!isiPad&&isRetina){
                ofImage::loadImage(url);
            }
        }
        if(!isAllocated())ofImage::loadImage(temp);
        
        
    }
    
    
    
};


#endif
