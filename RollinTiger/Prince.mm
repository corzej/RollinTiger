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
#define MAX_WALK_IMPULSE 2.2f
#define ANIM_SPEED 0.3f
#define MAX_VX 3.0f

@implementation Prince

@synthesize ball, bomb;

-(id) initWithGameLayer:(GameLayer*)gl
{
    // 1 - Initialize the prince
    self = [super initWithDynamicBody:@"right_1"
                      spriteFrameName:@"prince/right_1.png"];
    
    if(self)
    {
        // 2 - Do not let the prince rotate
        [self setFixedRotation:true];
        
        // 3 - The prince uses continuous collision detection
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
    // 1 - Call the super class
    [super updateCCFromPhysics];
    
    // 2 - Update animation phase
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
    
    // 3 - Get the current velocity
    b2Vec2 velocity = [self linearVelocity];
    float vX = velocity.x;
    
    // 4 - Determine direction of the prince
    bool isLeft = (direction < 0);
    
    if((isLeft && (vX > -MAX_VX)) || ((!isLeft && (vX < MAX_VX))))
    {
        // apply the directional impulse
        float impulse = clamp(-[self mass]*direction*WALK_FACTOR,
                              -MAX_WALK_IMPULSE,
                              MAX_WALK_IMPULSE);
        [self applyLinearImpulse:-b2Vec2(impulse,0) point:[self worldCenter]];
    }
    
    // 5 - Get direction as string
    NSString *dir = isLeft ? @"left" : @"right";
    
    // 6 - Update animation phase
    NSString *frameName;
    const float standingLimit = 0.1;
    if((vX > -standingLimit) && (vX < standingLimit))
    {
        // standing
        frameName = [NSString stringWithFormat:@"prince/left_1.png"];
    }
    else
    {
        // walking
        NSString *action = @"walk";
        frameName = [NSString stringWithFormat:@"prince/%@_%d.png", dir, animPhase];
    }
    
    // 7 - Set the display frame
    [self setDisplayFrameNamed:frameName];
}


-(void) ballCount{
    ball = ball +1;
    NSLog(@"ball count: %d", self.ball);
}
-(void) bombCount{
    bomb = bomb +1;
    NSLog(@"bomb count: %d", self.bomb);

}
@end