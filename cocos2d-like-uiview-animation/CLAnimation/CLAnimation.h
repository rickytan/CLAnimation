//
//  CLAnimation.h
//  cocos2d-like-uiview-animation
//
//  Created by ricky on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CLTiming <NSObject>
@required
- (CGFloat)valueForValue:(CGFloat)value;    // f(0) = 0, f(1) = 1 must be applied!

@end

typedef CGFloat (^TimingBlock)(CGFloat);

@interface CLTimingFunction : NSObject <CLTiming>
+ (id)timingFunctionWithTimingBlock:(TimingBlock)block;
+ (id)easeInFunctionWithRate:(CGFloat)rate;
+ (id)easeOutFunctionWithRate:(CGFloat)rate;
+ (id)elasticInFunctionWithRate:(CGFloat)rate;
+ (id)elasticOutFunctionWithRate:(CGFloat)rate;
@end

@interface CAAnimationSequence : CAAnimation
@property (nonatomic, copy) NSArray *animations;
+ (id)animationSequenceWithAnimations:(CAAnimation*)animation, ...;
@end

@interface CLAnimation : CAAnimation
@end

@interface CLAnimation (Move)

+ (id)animationMoveTo:(CGPoint)position;
+ (id)animationMoveTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveBy:(CGPoint)position;
+ (id)animationMoveBy:(CGPoint)position duration:(NSTimeInterval)duration;

@end

@interface CLAnimation (EaseMove)

+ (id)animationMoveEaseInTo:(CGPoint)position;
+ (id)animationMoveEaseInBy:(CGPoint)position;
+ (id)animationMoveEaseOutTo:(CGPoint)position;
+ (id)animationMoveEaseOutBy:(CGPoint)position;

+ (id)animationMoveEaseInTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseInBy:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseOutTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseOutBy:(CGPoint)position duration:(NSTimeInterval)duration;

+ (id)animationMoveEaseInTo:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseInBy:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseOutTo:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveEaseOutBy:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;

@end

@interface CLAnimation (ElasticMove)

+ (id)animationMoveElasticInTo:(CGPoint)position;
+ (id)animationMoveElasticInBy:(CGPoint)position;
+ (id)animationMoveElasticOutTo:(CGPoint)position;
+ (id)animationMoveElasticOutBy:(CGPoint)position;

+ (id)animationMoveElasticInTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveElasticInBy:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveElasticOutTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveElasticOutBy:(CGPoint)position duration:(NSTimeInterval)duration;

+ (id)animationMoveElasticInTo:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveElasticInBy:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveElasticOutTo:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveElasticOutBy:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;

@end

@interface CLAnimation (BounceMove)

+ (id)animationMoveBounceInTo:(CGPoint)position;
+ (id)animationMoveBounceInBy:(CGPoint)position;
+ (id)animationMoveBounceOutTo:(CGPoint)position;
+ (id)animationMoveBounceOutBy:(CGPoint)position;

+ (id)animationMoveBounceInTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveBounceInBy:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveBounceOutTo:(CGPoint)position duration:(NSTimeInterval)duration;
+ (id)animationMoveBounceOutBy:(CGPoint)position duration:(NSTimeInterval)duration;

+ (id)animationMoveBounceInTo:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveBounceInBy:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveBounceOutTo:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;
+ (id)animationMoveBounceOutBy:(CGPoint)position rate:(CGFloat)rate duration:(NSTimeInterval)duration;

@end

@interface UIView (CLAnimation)

+ (void)beginSequentialAnimations:(NSString *)animationID
                          context:(void *)context;
+ (void)commitSequentialAnimations;


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
