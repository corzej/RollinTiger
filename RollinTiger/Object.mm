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
    switch(rand() % 3)
    {
        case 0:
            objName = @"basketball";
            break;
            
        case 1:
            objName = @"missle";
            break;

            
        default:
            objName = @"missle";
            break;
    }
    return [[[self alloc] initWithObject:objName] autorelease];
}
@end
