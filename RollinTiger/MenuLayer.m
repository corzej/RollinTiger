//
//  MenuLayer.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/18/13.
//
//

#import "MenuLayer.h"
#import "GameLayer.h"
#import "InstructionLayer.h"

@implementation MenuLayer

+(CCScene *)scene{
    CCScene *scene = [CCScene node];
    MenuLayer *layer =[MenuLayer node];
    [scene addChild:layer];
    
    return scene;

}

- (id)init
{
    self = [super init];
    if (self) {
        //다이렉터에서 화면의 크기를 알아온다.
        CGSize size = [[CCDirector sharedDirector] winSize];
        //background
        CCSprite *background;
        background = [CCSprite spriteWithFile:@"backMenu.png"];
        background.position = ccp(size.width/2, size.height/2);
        
        // add the label as a child to this Layer
        [self addChild: background];

        //메뉴 아이템의 폰트를 변경한다.
        [CCMenuItemFont setFontName:@"AppleSDGothicNeo-Medium"];
        //메뉴 아이템 블럭
        CCMenuItem *startItem = [CCMenuItemFont itemWithString:@"Start" block:^(id sender)  {
                [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
        }];
        CCMenuItem *instructionItem = [CCMenuItemFont itemWithString:@"Instruction" block:^(id sender)  {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[InstructionLayer scene] withColor:ccWHITE]];
        }];
        //메뉴 버튼을 메뉴에 추가한다.
        CCMenu *menu = [CCMenu menuWithItems:startItem, nil];
        CCMenu *menu2 = [CCMenu menuWithItems:instructionItem, nil];

        //세로 정렬로 각 메뉴의 사잇값으로 20을 준다.
        [menu alignItemsVerticallyWithPadding:20];
        [menu2 alignItemsVerticallyWithPadding:20];

        //메뉴의 위치를 지정한다.
        [menu setPosition:ccp( size.width/2 +100, size.height/2)];
        [menu2 setPosition:ccp( size.width/2 -70, size.height/2)];
        //메뉴를 자식으로 추가한다.
        [self addChild:menu];
        [self addChild:menu2];


    }
    return self;
}

@end
