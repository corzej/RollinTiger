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
    float direction;      // keeps prince's direction (from accelerometer)
    int animPhase;        // the current animation phase
    ccTime animDelay;     // delay until the next animation phase is stated
    GameLayer *gameLayer; // weak reference}
}

@property (readonly) int ball;		//count the ball that prince get
@property (readonly) int bomb;		//count the bomb that prince get

-(id) initWithGameLayer:(GameLayer*)gl;
-(void) walk:(float)direction;

-(void)ballCount;
-(void)bombCount;
-(bool)isDead;

@end
