//
//  Prince.h
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//
#pragma once
#import "GB2Sprite.h"
#import "Cocos2d.h"

@class GameLayer;

@interface Prince : GB2Sprite{
    float direction;      // keeps monkey's direction (from accelerometer)
    int animPhase;        // the current animation phase
    ccTime animDelay;     // delay until the next animation phase is stated
    GameLayer *gameLayer; // weak reference}
    
    int ball;         //number of ball prince collected
    int bomb;         //number of bomb prince collected
}

@property (readonly) int ball;
@property (readonly) int bomb;

-(id) initWithGameLayer:(GameLayer*)gl;
-(void) walk:(float)direction;




-(void)ballCount;
-(void)bombCount;


@end
