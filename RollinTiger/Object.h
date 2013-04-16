//
//  Object.h
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/16/13.
//
//
#pragma once
#import "GB2Sprite.h"
#import "cocos2d.h"

@interface Object : GB2Sprite
{
    NSString *objName; // type of the object
}

@property (retain, nonatomic) NSString *objName;

-(id) initWithObject:(NSString*)objName;
+(Object*) randomObject;

@end
