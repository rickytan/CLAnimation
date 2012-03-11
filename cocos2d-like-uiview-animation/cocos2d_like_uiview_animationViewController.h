//
//  cocos2d_like_uiview_animationViewController.h
//  cocos2d-like-uiview-animation
//
//  Created by ricky on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cocos2d_like_uiview_animationViewController : UIViewController {
    
}

@property (nonatomic, assign) IBOutlet UIView *animateView;

- (IBAction)moveTo:(id)sender;
- (IBAction)moveEaseInTo:(id)sender;
- (IBAction)moveEaseInRate:(id)sender;
- (IBAction)bezierTo:(id)sender;
- (IBAction)elasticTo:(id)sender;
- (IBAction)bounceTo:(id)sender;
- (IBAction)fadeIn:(id)sender;
- (IBAction)scaleTo:(id)sender;
@end
