//
//  iAdSingleton.h
//  RollinTiger
//
//  Created by Eung Jin Lee on 4/25/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <iAd/iAd.h>

@interface iAdSingleton :NSObject  <ADBannerViewDelegate>
{
    ADBannerView *bannerView;
    UINavigationController *navController;
}

@property (nonatomic,retain) ADBannerView *bannerView;

+(iAdSingleton *)sharedInstance;
-(void)createAdView;

@end