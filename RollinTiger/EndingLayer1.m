//
//  EndingLayer1.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/29/13.
//
//

#import "EndingLayer1.h"
#import "MenuLayer.h"

@implementation EndingLayer1

+(CCScene *)scene{
    CCScene *scene = [CCScene node];
    EndingLayer1 *layer =[EndingLayer1 node];
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
        background = [CCSprite spriteWithFile:@"Ending1.png"];
        background.position = ccp(size.width/2, size.height/2);
        
        // add the label as a child to this Layer
        [self addChild: background];
        
        //메뉴 아이템의 폰트를 변경한다.
        [CCMenuItemFont setFontName:@"AppleSDGothicNeo-Medium"];
        //메뉴 아이템 블럭
        CCMenuItem *startItem = [CCMenuItemFont itemWithString:@"Main Menu" block:^(id sender)  {
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuLayer scene] withColor:ccWHITE]];
        }];
        
        //메뉴 버튼을 메뉴에 추가한다.
        CCMenu *menu = [CCMenu menuWithItems:startItem, nil];
        //세로 정렬로 각 메뉴의 사잇값으로 20을 준다.
        [menu alignItemsVerticallyWithPadding:20];
        //메뉴의 위치를 지정한다.
        [menu setPosition:ccp( size.width/2, size.height/2-100)];
        //메뉴를 자식으로 추가한다.
        [self addChild:menu];
        
    }
    return self;
}
@end
