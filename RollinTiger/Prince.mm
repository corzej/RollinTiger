//
//  Prince.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//

#import "Prince.h"
#import "GB2Contact.h"
#import "GMath.h"
#import "Object.h"
#import "SimpleAudioEngine.h"
#import "GameLayer.h"


#define JUMP_IMPULSE 6.0f
#define WALK_FACTOR 3.0f
#define MAX_WALK_IMPULSE 0.2f
#define ANIM_SPEED 0.3f
#define MAX_VX 2.0f

@implementation Prince

-(id) initWithGameLayer:(GameLayer*)gl
{
    // 1 - Initialize the monkey
    self = [super initWithDynamicBody:@"right_1"
                      spriteFrameName:@"prince/right_1.png"];
    
    if(self)
    {
        // 2 - Do not let the monkey rotate
        [self setFixedRotation:true];
        
        // 3 - The monkey uses continuous collision detection
        // to avoid getting stuck inside fast-falling objects
        [self setBullet:YES];
        
        // 4 - Store the game layer
        gameLayer = gl;
    }
    
    return self;
}

-(void) walk:(float)newDirection
{
    direction = newDirection;
}

-(void) updateCCFromPhysics
{
    // 1- Call the super class
    [super updateCCFromPhysics];
    
    // 2 - Apply the directional impulse
    float impulse = clamp(-[self mass]*direction*WALK_FACTOR,
                          -MAX_WALK_IMPULSE,
                          MAX_WALK_IMPULSE);
    [self applyLinearImpulse:-b2Vec2(impulse,0) point:[self worldCenter]];
    
    animDelay -= 1.0f/60.0f;
    if(animDelay <= 0)
    {
        animDelay = ANIM_SPEED;
        animPhase++;
        if(animPhase > 2)
        {
            animPhase = 1;
        }
    }
    
    // determine direction of the monkey
    bool isLeft = (direction < 0);
    
    // direction as string
    NSString *dir = isLeft ? @"left" : @"right";
    
    // update animation phase
    NSString *frameName;
    const float standingLimit = 0.1;
    float vX = [self linearVelocity].x;
    if((vX > -standingLimit) && (vX < standingLimit))
    {
        // standing
        frameName = [NSString stringWithFormat:@"prince/left_2.png"];
    }
    else
    {
        // walking
        NSString *action = @"walk";
        frameName = [NSString stringWithFormat:@"prince/%@_%d.png", dir, animPhase];
    }
    
    // set the display frame
    [self setDisplayFrameNamed:frameName];
}

@end