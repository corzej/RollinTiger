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
}
-(id) initWithGameLayer:(GameLayer*)gl;
-(void) walk:(float)direction;

@end
