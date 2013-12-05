//
//  CLAnimation.h
//  cocos2d-like-uiview-animation
//
//  Created by ricky on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CGFloat (^TimingBlock)(CGFloat);

@interface CLTimingFunction : NSObject
+ (id)timingFunctionWithTimingBlock:(TimingBlock)block;
@end

@interface CAAnimationSequence : CAAnimation
@property (nonatomic, copy) NSArray *animations;
+ (id)animationSequenceWithAnimations:(CAAnimation*)animation, ...;
@end

@interface CAAnimation (CLAnimation_Move)

+ (id)animationMoveTo:(CGPoint)position;
+ (id)animationMoveTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveBy:(CGPoint)position;
+ (id)animationMoveBy:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseInTo:(CGPoint)position;
+ (id)animationMoveEaseInBy:(CGPoint)position;
+ (id)animationMoveEaseOutTo:(CGPoint)position;

@end

@interface UIView (CLAnimation)

//+ (void)beginSequenceCLAnimations:(NSString *)animationID;
//+ (void)beginSpanCLAnimations:(NSString *)animationID;
//+ (void)commitCLAnimations;


- (void)addSequentialAnimations:(CAAnimation*)animation, ...;


    // Position Based Animation
- (void)moveTo:(CGPoint)point;
- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveEaseInTo:(CGPoint)point;
- (void)moveEaseInTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveEaseInTo:(CGPoint)point rate:(CGFloat)rate;
- (void)moveEaseInTo:(CGPoint)point rate:(CGFloat)rate duration:(NSTimeInterval)duration;
- (void)moveEaseOutTo:(CGPoint)point;
- (void)moveEaseOutTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveEaseOutTo:(CGPoint)point rate:(CGFloat)rate;
- (void)moveEaseOutTo:(CGPoint)point rate:(CGFloat)rate duration:(NSTimeInterval)duration;
- (void)moveEaseOutElasticTo:(CGPoint)point;
- (void)moveEaseOutElasticTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveEaseInElasticTo:(CGPoint)point;
- (void)moveEaseInElasticTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveEaseOutBounceTo:(CGPoint)point;
- (void)moveEaseOutBounceTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveEaseInBounceTo:(CGPoint)point;
- (void)moveEaseInBounceTo:(CGPoint)point duration:(NSTimeInterval)duration;
- (void)moveBy:(CGPoint)point;

- (void)bezierTo:(CGPoint)point withControlPoint0:(CGPoint)p0 andControlPoint1:(CGPoint)p1;
- (void)bezierTo:(CGPoint)point withControlPoint0:(CGPoint)p0 andControlPoint1:(CGPoint)p1 duration:(NSTimeInterval)duration;
- (void)bezierEaseInTo:(CGPoint)point 
     withControlPoint0:(CGPoint)p0 
      andControlPoint1:(CGPoint)p1;
- (void)bezierEaseInTo:(CGPoint)point 
     withControlPoint0:(CGPoint)p0
      andControlPoint1:(CGPoint)p1
                  rate:(CGFloat)rate;
- (void)bezierEaseOutTo:(CGPoint)point 
      withControlPoint0:(CGPoint)p0 
       andControlPoint1:(CGPoint)p1;
- (void)bezierEaseOutTo:(CGPoint)point 
      withControlPoint0:(CGPoint)p0
       andControlPoint1:(CGPoint)p1
                   rate:(CGFloat)rate;
- (void)bezierElasticTo:(CGPoint)point 
      withControlPoint0:(CGPoint)p0 
       andControlPoint1:(CGPoint)p1;
- (void)bezierBy:(CGPoint)point withControlPoint0:(CGPoint)p0 andControlPoint1:(CGPoint)p1;

- (void)jumpTo:(CGPoint)point;
- (void)jumpBy:(CGPoint)point;

    // Scale Based Animation
- (void)scaleTo:(CGFloat)scale;
- (void)scaleTo:(CGFloat)scale duration:(NSTimeInterval)duration;
- (void)scaleXTo:(CGFloat)scalex;
- (void)scaleXTo:(CGFloat)scalex duration:(NSTimeInterval)duration;
- (void)scaleYTo:(CGFloat)scaley;
- (void)scaleYTo:(CGFloat)scaley duration:(NSTimeInterval)duration;
- (void)scaleEaseOutTo:(CGFloat)scale;
- (void)scaleEaseOutTo:(CGFloat)scale duration:(NSTimeInterval)duration;
- (void)scaleEaseInTo:(CGFloat)scale;
- (void)scaleEaseInTo:(CGFloat)scale duration:(NSTimeInterval)duration;
- (void)scaleEaseOutElascticTo:(CGFloat)scale;
- (void)scaleEaseOutElascticTo:(CGFloat)scale duration:(NSTimeInterval)duration;

- (void)pinch;

    // Rotate Based Animation
- (void)rotateTo:(CGFloat)angle;


    // Opacity Based Aniamtion;
- (void)fadeIn;
- (void)fadeIn:(NSTimeInterval)duration;
- (void)fadeOut;
- (void)fadeOut:(NSTimeInterval)duration;
- (void)blink;
- (void)blink:(NSTimeInterval)duration;

@end
