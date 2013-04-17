//
//  Hud.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/17/13.
//
//

#import "Hud.h"
#import "Prince.h"
#import "GMath.h"

@implementation Hud

-(id) init
{
    self = [super initWithFile:@"objects.pvr.ccz" capacity:20];
    
    if(self)
    {

        
        // cache sprite frames for the digits
        CCSpriteFrameCache *sfc = [CCSpriteFrameCache sharedSpriteFrameCache];
        for(int i=0; i<10; i++)
        {
            digitFrame[i] = [sfc spriteFrameByName:
                             [NSString stringWithFormat:@"numbers/%d.png", i]];
        }
        
        // init digit sprites
        for(int i=0; i<MAX_DIGITS; i++)
        {
            digits[i] = [CCSprite spriteWithSpriteFrame:digitFrame[0]];
            digits[i].position = ccp(200+i*25, 460);
            [self addChild:digits[i]];
        }
    }
    
    return self;
}


-(void) setScore:(float) score
{
    char strbuf[MAX_DIGITS+1];
    memset(strbuf, 0, MAX_DIGITS+1);
    
    snprintf(strbuf, MAX_DIGITS+1, "%*d", MAX_DIGITS, (int)roundf(score));
    int i=0;
    for(; i<MAX_DIGITS; i++)
    {
        if(strbuf[i] != ' ')
        {
            [digits[i] setDisplayFrame:digitFrame[strbuf[i]-'0']];
            [digits[i] setVisible:YES];
        }
        else
        {
            [digits[i] setVisible:NO];
        }
    }
}


@end
