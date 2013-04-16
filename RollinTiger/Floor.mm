//
//  Floor.m
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//

#import "Floor.h"

@implementation Floor

+(Floor *) floorSprite{
    return [[[self alloc] initWithStaticBody:@"grassfront" spriteFrameName:@"floor/grassfront.png"]autorelease];
}
@end
