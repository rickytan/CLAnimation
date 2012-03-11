//
//  cocos2d_like_uiview_animationAppDelegate.h
//  cocos2d-like-uiview-animation
//
//  Created by ricky on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class cocos2d_like_uiview_animationViewController;

@interface cocos2d_like_uiview_animationAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet cocos2d_like_uiview_animationViewController *viewController;

@end
