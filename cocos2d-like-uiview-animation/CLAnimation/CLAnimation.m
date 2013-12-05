//
//  CLAnimation.m
//  cocos2d-like-uiview-animation
//
//  Created by ricky on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CLAnimation.h"
#import <QuartzCore/QuartzCore.h>

@interface CAAnimationSequence ()
{
@private
    NSMutableArray              * _animations;
    
    NSString                    * _event;
    id                            _object;
    NSDictionary                * _dict;
    
}
@end

@implementation CAAnimationSequence
@synthesize animations = _animations;

+ (id)animationSequenceWithAnimations:(CAAnimation *)animation, ...
{
    CAAnimationSequence *sequence = [CAAnimationSequence animation];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    va_list anim;
    va_start(anim, animation);
    CAAnimation* value = va_start(anim, animation);
    while (value) {
        [arr addObject:value];
        value = va_arg(anim, CAAnimation*);
    }
    
    sequence.animations = [NSArray arrayWithArray:arr];
    return sequence;
}

- (void)dealloc
{
    [_animations release];
    [_event release];
    [_object release];
    [_dict release];
    [super dealloc];
}

- (void)setAnimations:(NSArray *)animations
{
    if (_animations != animations) {
        [_animations release];
        _animations = [animations mutableCopy];
        
        CFTimeInterval duration = 0.0;
        for (CAAnimation *anim in _animations) {
            //NSAssert(anim.repeatCount == 0.0, @"Can't add any animation that repeats!");
            anim.delegate = self;
            duration += anim.duration;
        }
        self.duration = duration;
    }
}

- (void)runNext
{
    if (self.animations.count) {
        CAAnimation *first = self.animations[0];
        [first runActionForKey:_event
                        object:_object
                     arguments:_dict];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(animationDidStop:finished:)])
            [self.delegate animationDidStop:self
                                   finished:YES];
    }
}

- (void)runActionForKey:(NSString *)event
                 object:(id)anObject
              arguments:(NSDictionary *)dict
{
    _event = [event retain];
    _object = [anObject retain];
    _dict = [_dict retain];
    
    [self runNext];
    
    if ([self.delegate respondsToSelector:@selector(animationDidStart:)])
        [self.delegate animationDidStart:self];
}

#pragma mark - CAAnimation Delegate

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim
                finished:(BOOL)flag
{
    if (flag) {
        [_animations removeObject:anim];
        [self runNext];
    }
    else {
        if ([self.delegate respondsToSelector:@selector(animationDidStop:finished:)])
            [self.delegate animationDidStop:self
                                   finished:NO];
    }
}

@end

static NSString *DEFAULT_KEY = @"CLAnimation";

static const NSInteger DEFAULT_OPTIONS = UIViewAnimationOptionAllowAnimatedContent |
UIViewAnimationOptionAllowUserInteraction |
UIViewAnimationOptionBeginFromCurrentState;

static BOOL runImmediately = YES;


@interface CABasicAnimation (CLAnimation)
+ (id)animationPositionFrom:(CGPoint)start
                         to:(CGPoint)end
                   duration:(NSTimeInterval)duration;
+ (id)animationScaleFrom:(CGFloat)start
                      to:(CGFloat)end
                duration:(NSTimeInterval)duration;
@end

@implementation CABasicAnimation (CLAnimation)

+ (id)animationPositionFrom:(CGPoint)start
                         to:(CGPoint)end
                   duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:start];
    animation.toValue = [NSValue valueWithCGPoint:end];
    animation.duration = duration;
    animation.repeatCount = 0;
    
    return animation;
}

+ (id)animationScaleFrom:(CGFloat)start
                      to:(CGFloat)end
                duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"scale"];
    animation.fromValue = [NSNumber numberWithFloat:start];
    animation.toValue = [NSNumber numberWithFloat:end];
    animation.duration = duration;
    animation.repeatCount = 0;
    
    return animation;
}

@end

@interface CAKeyframeAnimation (CLAnimation)
+ (id)animationPositionFrom:(CGPoint)start
                         to:(CGPoint)end
                   duration:(NSTimeInterval)duration
                     frames:(NSInteger)frames
            withTimingBlock:(TimingBlock)block;
+ (id)animationScaleFrom:(CGFloat)start
                      to:(CGFloat)end
                duration:(NSTimeInterval)duration
                  frames:(NSInteger)frames
         withTimingBlock:(TimingBlock)block;
@end

@implementation CAKeyframeAnimation (CLAnimation)

+ (id)animationPositionFrom:(CGPoint)start
                         to:(CGPoint)end
                   duration:(NSTimeInterval)duration
                     frames:(NSInteger)frames
            withTimingBlock:(TimingBlock)block
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.calculationMode = kCAAnimationLinear;
    animation.repeatCount = 0;
    animation.duration = duration;
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:frames];
    CGFloat time = 0.0f;
    NSAssert(frames > 1,@"Frames must be larger than 1");
    CGFloat timeStep = 1.0f / (frames - 1);
    CGPoint delta = CGPointMake(end.x - start.x, end.y - start.y);
    for (int i=0; i<frames ; ++i) {
        CGPoint p = CGPointMake(start.x + block(time)*delta.x,
                                start.y + block(time)*delta.y);
        [values addObject:[NSValue valueWithCGPoint:p]];
        time += timeStep;
    }
    animation.values = values;
    
    return animation;
}

+ (id)animationScaleFrom:(CGFloat)start
                      to:(CGFloat)end
                duration:(NSTimeInterval)duration
                  frames:(NSInteger)frames
         withTimingBlock:(TimingBlock)block
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.calculationMode = kCAAnimationLinear;
    animation.repeatCount = 0;
    animation.duration = duration;
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:frames];
    CGFloat time = 0.0f;
    NSAssert(frames > 1,@"Frames must be larger than 1");
    CGFloat timeStep = 1.0f / (frames - 1);
    CGFloat delta = end - start;
    for (int i=0; i<frames ; ++i) {
        CGFloat f = start + block(time)*delta;
        CATransform3D transform = CATransform3DMakeScale(f, f, 1);
        [values addObject:[NSValue valueWithCATransform3D:transform]];
        time += timeStep;
    }
    animation.values = values;
    
    return animation;
}

@end

@implementation UIView (CLAnimation)
/*
+ (void)beginSequenceCLAnimations:(NSString *)animationID
{
    runImmediately = NO;
}

+ (void)commitCLAnimations
{
    runImmediately = YES;
}
*/
- (void)moveTo:(CGPoint)point
{
    [self moveTo:point duration:0.35];
}

- (void)moveTo:(CGPoint)point duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationPositionFrom:self.center
                                                                       to:point
                                                                 duration:duration];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)moveEaseInTo:(CGPoint)point
{
    [self moveEaseInTo:point duration:0.35];
}

- (void)moveEaseInTo:(CGPoint)point duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationPositionFrom:self.center
                                                                       to:point
                                                                 duration:duration];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)moveEaseInTo:(CGPoint)point rate:(CGFloat)rate
{
    [self moveEaseInTo:point rate:rate duration:0.35];
}

- (void)moveEaseInTo:(CGPoint)point rate:(CGFloat)rate duration:(NSTimeInterval)duration
{
    TimingBlock block = ^(CGFloat time){
        return powf(time, rate);
    };
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationPositionFrom:self.center
                                                                             to:point
                                                                       duration:duration
                                                                         frames:32
                                                                withTimingBlock:block];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)moveEaseOutTo:(CGPoint)point
{
    [self moveEaseOutTo:point duration:0.35];
}

- (void)moveEaseOutTo:(CGPoint)point duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationPositionFrom:self.center
                                                                       to:point
                                                                 duration:duration];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)moveEaseInElasticTo:(CGPoint)point
{
    [self moveEaseInElasticTo:point duration:0.35];
}

- (void)moveEaseInElasticTo:(CGPoint)point duration:(NSTimeInterval)duration
{
    TimingBlock block = ^(CGFloat ratio){
        if (ratio == 0.0f || ratio == 1.0f)
            return ratio;
        else
        {
            float p = 0.3f;
            float s = p / 4.0f;
            float invRatio = ratio - 1.0f;
            return -1.0f * powf(2.0f, 8.0f*invRatio) * sinf((invRatio-s)*2*M_PI/p);
        }
    };
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationPositionFrom:self.center
                                                                             to:point
                                                                       duration:duration
                                                                         frames:32
                                                                withTimingBlock:block];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)moveEaseOutElasticTo:(CGPoint)point
{
    [self moveEaseOutElasticTo:point duration:0.35];
}

- (void)moveEaseOutElasticTo:(CGPoint)point duration:(NSTimeInterval)duration
{
    TimingBlock block = ^(CGFloat ratio){
        if (ratio == 0.0f || ratio == 1.0f)
            return ratio;
        else
        {
            float p = 0.3f;
            float s = p / 4.0f;
            return powf(2.0f, -8.0f*ratio) * sinf((ratio-s)*2*M_PI/p) + 1.0f;
        }
    };
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationPositionFrom:self.center
                                                                             to:point
                                                                       duration:duration
                                                                         frames:32
                                                                withTimingBlock:block];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)moveEaseOutBounceTo:(CGPoint)point
{
    [self moveEaseOutBounceTo:point duration:0.35];
}

- (void)moveEaseOutBounceTo:(CGPoint)point duration:(NSTimeInterval)duration
{
    
    TimingBlock block = ^(CGFloat ratio){
        float s = 7.5625f;
        float p = 2.75f;
        float l;
        if (ratio < (1.0f/p))
        {
            l = s * powf(ratio, 2.0f);
        }
        else
        {
            if (ratio < (2.0f/p))
            {
                ratio -= 1.5f/p;
                l = s * powf(ratio, 2.0f) + 0.75f;
            }
            else
            {
                if (ratio < 2.5f/p)
                {
                    ratio -= 2.25f/p;
                    l = s * powf(ratio, 2.0f) + 0.9375f;
                }
                else
                {
                    ratio -= 2.625f/p;
                    l = s * powf(ratio, 2.0f) + 0.984375f;
                }
            }
        }
        return l;
    };
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationPositionFrom:self.center
                                                                             to:point
                                                                       duration:duration
                                                                         frames:32
                                                                withTimingBlock:block];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)bezierTo:(CGPoint)point withControlPoint0:(CGPoint)p0 andControlPoint1:(CGPoint)p1
{
    [self bezierTo:point
 withControlPoint0:p0
  andControlPoint1:p1
          duration:0.35];
}
- (void)bezierTo:(CGPoint)point withControlPoint0:(CGPoint)p0 andControlPoint1:(CGPoint)p1 duration:(NSTimeInterval)duration
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, self.center.x, self.center.y);
    CGPathAddCurveToPoint(path, nil, p0.x, p0.y, p1.x, p1.y, point.x, point.y);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.repeatCount = 0;
    animation.duration = duration;
    CGPathRelease(path);
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.position = point;
    }
    else {
        
    }
}

- (void)scaleEaseOutElascticTo:(CGFloat)scale
{
    [self scaleEaseOutElascticTo:scale duration:0.35];
}

- (void)scaleEaseOutElascticTo:(CGFloat)scale duration:(NSTimeInterval)duration
{
    TimingBlock block = ^(CGFloat ratio){
        if (ratio == 0.0f || ratio == 1.0f)
            return ratio;
        else
        {
            float p = 0.3f;
            float s = p / 4.0f;
            return powf(2.0f, -8.0f*ratio) * sinf((ratio-s)*2*M_PI/p) + 1.0f;
        }
    };
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationScaleFrom:1.0
                                                                          to:scale
                                                                    duration:duration
                                                                      frames:32
                                                             withTimingBlock:block];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.transform = CATransform3DMakeScale(scale, scale, 1);
    }
    else {
        
    }
}



- (void)fadeIn
{
    [self fadeIn:0.35];
}

- (void)fadeIn:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.repeatCount = 0;
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    
    if (runImmediately) {
        [self.layer addAnimation:animation
                          forKey:DEFAULT_KEY];
        self.layer.opacity = 1.0;
    }
    else {
        
    }
}

@end
