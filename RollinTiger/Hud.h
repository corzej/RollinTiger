//
//  Hud.h
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/17/13.
//
//

#pragma once

#import "cocos2d.h"

#define MAX_ENERGY_TOKENS 10
#define MAX_DIGITS 5

@interface Hud : CCSpriteBatchNode
{
    CCSprite *digits[MAX_DIGITS];  // weak references
    CCSpriteFrame *digitFrame[10]; // weak references
    

}

-(id) init;

/**
 * Set the score
 * @param score the score to display
 */
-(void) setScore:(float) score;



@end
