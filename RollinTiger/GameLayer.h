//
//  GameLayer.h
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//
#pragma once
#import "cocos2d.h"
@class Object;
@class Prince;
@class Hud;


// GameLayer
@interface GameLayer : CCLayer
{
    CCSprite *background;                   //!< weak reference
    CCSprite *floorBackground;              //!< weak reference
    CCSpriteBatchNode* objectLayer;         //!< weak reference
    
    ccTime nextDrop;                        //!< delay until next item drop
    ccTime dropDelay;                       //!< delay between drops
    
    Object *nextObject;                     //!< weak reference
    Object *nextObject2;                     //!< weak reference
    Object *nextObject3;                     //!< weak reference
    Object *nextObject4;                     //!< weak reference
    
    Prince *prince;
    Hud *hud;                               //!< weak reference
    
    ccTime gameOverTimer;                   //!< timer for restart of the level

    //timer
    CCLabelTTF *timeLabel;
    double startTime;

}

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;
//timer
-(void)displaySecs:(double)secs;
@end
