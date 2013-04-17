//
//  Object.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//
#import "Object.h"
#import "GB2Contact.h"
#import "SimpleAudioEngine.h"
#import "GMath.h"
#import "Prince.h"

@implementation Object

@synthesize objName;

-(id) initWithObject:(NSString*)theObjName
{
    self = [super initWithDynamicBody:theObjName
                      spriteFrameName:[NSString stringWithFormat:@"stuffs/%@.png", theObjName]];
    if(self)
    {
        self.objName = theObjName;
    }
    return self;
}

-(void) dealloc
{
    [objName release];
    [super dealloc];
}

+(Object*) randomObject
{
    NSString *objName;
    switch(rand() % 2)
    {
        case 0:
            return [[[Ball alloc]initWithObject:@"basketball"]autorelease];
        default:
            return [[[Bomb alloc]initWithObject:@"missle"]autorelease];
    }
    return [[[self alloc] initWithObject:objName] autorelease];
}

-(void) beginContactWithObject:(GB2Contact*)contact
{
    b2Vec2 velocity = [self linearVelocity];
    
    // play the sound only when the impact is high
/*    if(velocity.LengthSquared() > 3.0)
    {
        // play the item hit sound
        // pan it depending on the position of the collision
        // add some randomness to the pitch
        [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%@.caf", objName]
                                               pitch:gFloatRand(0.8,1.2)
                                                 pan:(self.ccNode.position.x-240.0f) / 240.0f
                                                gain:1.0 ];
        
    }
*/
}

-(void) beginContactWithFloor:(GB2Contact*)contact
{
    // just treat the contact with the floor
    // in the same way as contact with another object
    [self beginContactWithObject:contact];
    // fade & shrink object
    // and delete after animation
    [self runAction:
     [CCSequence actions:
      [CCSpawn actions:
       [CCFadeOut actionWithDuration:0],
       [CCScaleTo actionWithDuration:0 scale:0.0],
       nil],
      [CCCallFunc actionWithTarget:self selector:@selector(deleteNow)],
      nil]
     ];
    
}

@end



@implementation ConsumableObject

-(void) consume
{
    if(!consumed)
    {
        // set consumed
        consumed = YES;
        
        // fade & shrink object
        // and delete after animation
        [self runAction:
         [CCSequence actions:
          [CCSpawn actions:
           [CCFadeOut actionWithDuration:0.1],
           [CCScaleTo actionWithDuration:0.2 scale:0.0],
           nil],
          [CCCallFunc actionWithTarget:self selector:@selector(deleteNow)],
          nil]
         ];
        
        // play the item comsumed sound
        // pan it depending on the position of the monkey
        // add some randomness to the pitch
        [[SimpleAudioEngine sharedEngine] playEffect:@"gulp.caf"
                                               pitch:gFloatRand(0.8,1.2)
                                                 pan:(self.ccNode.position.x-240.0f) / 240.0f
                                                gain:1.0 ];
    }
}

-(void) presolveContactWithPrince:(GB2Contact*)contact
{
    // disabling the contact avoids the object bouncing
    // off from the monkey and moving the monkey
    [contact setEnabled:NO];
}


@end

@implementation Ball
-(void) beginContactWithPrince:(GB2Contact*)contact
{
    if(!consumed)
    {
        Prince *prince = (Prince *)contact.otherObject;
        [prince ballCount];
        [self consume];
    }
}
@end

@implementation Bomb
-(void) beginContactWithPrince:(GB2Contact*)contact
{
    if(!consumed)
    {
        Prince *prince = (Prince *)contact.otherObject;
        [prince bombCount];
        [self consume];
    }
}
@end