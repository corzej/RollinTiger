//
//  GameLayer.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//

// Import the interfaces
#import "GameLayer.h"
#import "GB2DebugDrawLayer.h"
#import "GB2Sprite.h"
#import "Floor.h"
#import "Object.h"
#import "GMath.h"
#import "SimpleAudioEngine.h"
#import "Prince.h"
#import "Hud.h"

// HelloWorldLayer implementation
@implementation GameLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init]))
    {
        // load sprite atlases
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"objects.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background.plist"];
        
        // load physics shapes
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"shapes.plist"];
        
	    // Setup background layer
        background = [CCSprite spriteWithSpriteFrameName:@"Background.png"];
        [self addChild:background z:0];
        background.anchorPoint = ccp(0,0);
        background.position = ccp(0,0);
        
        // Setup floor background
        floorBackground = [CCSprite spriteWithSpriteFrameName:@"floor/grassbehind.png"];
        [self addChild:floorBackground z:1];
        floorBackground.anchorPoint = ccp(0,0);
        floorBackground.position = ccp(0,0);
        
        // add the debug draw layer, uncomment this if something strange happens ;)
        //      [self addChild:[[GB2DebugDrawLayer alloc] init] z:30];
        
        // Setup object layer
    	objectLayer = [CCSpriteBatchNode batchNodeWithFile:@"objects.pvr.ccz" capacity:150];
        [self addChild:objectLayer z:10];
        
        // Setup floor front layer, physics position is 0/0 by default
        [objectLayer addChild:[[Floor floorSprite] ccNode] z:20];
        
        // add walls to the left
        GB2Node *leftWall = [[GB2Node alloc] initWithStaticBody:nil node:nil];
        [leftWall addEdgeFrom:b2Vec2FromCC(0, 0) to:b2Vec2FromCC(0, 10000)];
        
        // add walls to the right
        GB2Node *rightWall = [[GB2Node alloc] initWithStaticBody:nil node:nil];
        [rightWall addEdgeFrom:b2Vec2FromCC(320, 0) to:b2Vec2FromCC(320, 10000)];
        
        nextDrop = 3.0f;  // drop first object after 3s
        dropDelay = 1.0f; // drop next object after 1s
        
        [SimpleAudioEngine sharedEngine];
        
        [self scheduleUpdate];
        
        //add prince
        prince = [[[Prince alloc] initWithGameLayer:self] autorelease];
        [objectLayer addChild:[prince ccNode] z:10000];
        [prince setPhysicsPosition:b2Vec2FromCC(240,150)];
        
        //enabling movement
        self.isAccelerometerEnabled = YES;
        
        // add hud
        hud = [[[Hud alloc] init] autorelease];
        [self addChild:hud z:10000];
    }
    
	return self;
}

-(void) update: (ccTime) dt
{

    for (int i=1; i<7; i++) {
        
    // drop next item
    nextDrop -= dt*0.1*i;
    if(nextDrop <= 0)
    {
        if(nextObject)
        {
            // let the object drop
            [nextObject setActive:YES];
            [nextObject2 setActive:YES];

            // set next drop time
            nextDrop = dropDelay;
            
            // reduce delay to the drop after this
            // this will increase game&#039;s difficulty
            
        }
        
        // create new random object
        nextObject = [Object randomObject];
        nextObject2 = [Object randomObject];

        
        // but keep it disabled
        [nextObject setActive:NO];
        [nextObject2 setActive:NO];

        
        // set position
        float xPos = gFloatRand(40,300);
        float xPos2 = gFloatRand(40,300);
        float yPos = 500;
        [nextObject setPhysicsPosition:b2Vec2FromCC(xPos, yPos)];
        [nextObject2 setPhysicsPosition:b2Vec2FromCC(xPos2, yPos)];

        // add it to our object layer
        [objectLayer addChild:[nextObject ccNode]];
        [objectLayer addChild:[nextObject2 ccNode]];

    }
    }
    [hud setScore:prince.ball];

}

- (void)accelerometer:(UIAccelerometer*)accelerometer
        didAccelerate:(UIAcceleration*)acceleration
{
    // forward accelerometer value to monkey
    [prince walk:acceleration.x];
}

@end
