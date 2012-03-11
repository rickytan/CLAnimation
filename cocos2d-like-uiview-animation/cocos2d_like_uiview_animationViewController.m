//
//  cocos2d_like_uiview_animationViewController.m
//  cocos2d-like-uiview-animation
//
//  Created by ricky on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d_like_uiview_animationViewController.h"
#import "CLAnimation.h"

@implementation cocos2d_like_uiview_animationViewController
@synthesize animateView;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)moveTo:(id)sender
{
    self.animateView.center = CGPointMake(100, 100);
    [self.animateView moveTo:CGPointMake(700, 700)];
}

- (IBAction)moveEaseInTo:(id)sender
{
        self.animateView.center = CGPointMake(100, 100);
    [self.animateView moveEaseInTo:CGPointMake(700, 700)];
}

- (IBAction)moveEaseInRate:(id)sender
{
        self.animateView.center = CGPointMake(100, 100);
    [self.animateView moveEaseInTo:CGPointMake(700, 700)
                              rate:5];
}

- (IBAction)elasticTo:(id)sender
{
        self.animateView.center = CGPointMake(100, 100);
    [self.animateView moveEaseOutElasticTo:CGPointMake(700, 700) 
                           duration:1.2];
}

- (IBAction)bounceTo:(id)sender
{
    self.animateView.center = CGPointMake(100, 100);
    [self.animateView moveEaseOutBounceTo:CGPointMake(700, 700)];
}

- (IBAction)bezierTo:(id)sender
{
    self.animateView.center = CGPointMake(100, 100);
    [self.animateView bezierTo:CGPointMake(700, 700)
             withControlPoint0:CGPointMake(400, -100)
              andControlPoint1:CGPointMake(600, 200)];
}
- (IBAction)scaleTo:(id)sender
{
    self.animateView.transform = CGAffineTransformIdentity;
    [self.animateView scaleEaseOutElascticTo:2];
}

- (IBAction)fadeIn:(id)sender
{
    [self.animateView fadeIn];
}
@end
