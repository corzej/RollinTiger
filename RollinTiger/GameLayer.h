//
//  GameLayer.h
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//

#import "cocos2d.h"
@class Object;
// GameLayer
@interface GameLayer : CCLayer
{
    CCSprite *background;                   //!< weak reference
    CCSprite *floorBackground;              //!< weak reference
    CCSpriteBatchNode* objectLayer;         //!< weak reference
    
    ccTime nextDrop;                        //!< delay until next item drop
    ccTime dropDelay;                       //!< delay between drops
    
    Object *nextObject;                     //!< weak reference
}

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;
@end
