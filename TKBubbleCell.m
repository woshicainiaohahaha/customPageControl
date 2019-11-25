//
//  TKBubbleCell.m
//  TKRubberControl
//
//  Created by 李东岩 on 2019/11/22.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import "TKBubbleCell.h"

@implementation TKBubbleCell

- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        _bubbleScale = 0.5;
        _styleConfig = [[TKRubberPageControlConfig alloc] init];
        [self setupLayer];
    }
    return self;
}

- (id)initWithStyle:(TKRubberPageControlConfig *)style {
    if (self = [super init]) {
        _bubbleScale = 0.5;
        _styleConfig = style;
        [self setupLayer];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        _bubbleScale = 0.5;
        _styleConfig = [[TKRubberPageControlConfig alloc] init];
        [self setupLayer];
    }
    return self;
}

- (void)setupLayer {
    self.frame = CGRectMake(0, 0, _styleConfig.smallBubbleSize, _styleConfig.smallBubbleSize);
    _bubbleLayer = [CAShapeLayer layer];
    _bubbleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    _bubbleLayer.fillColor = _styleConfig.smallBubbleColor.CGColor;
    _bubbleLayer.strokeColor = _styleConfig.backgroundColor.CGColor;
    _bubbleLayer.lineWidth = _styleConfig.bubbleXOffsetSpace/8;
    [self addSublayer:_bubbleLayer];
}

- (void)positionChange:(TKMoveDirection)direction radius:(CGFloat)radius duration:(CFTimeInterval)duration beginTime:(CFTimeInterval)beginTime {
    _toLeft = direction == left;
    UIBezierPath *movePath = [[UIBezierPath alloc] init];
    CGPoint center = CGPointZero;
    CGFloat startAngle = _toLeft?0:M_PI;
    CGFloat endAngle = _toLeft?M_PI:0;
    center.x += radius*(_toLeft?-1:1);
    _lastDirection = direction;
    
    [movePath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:_toLeft];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = duration;
    positionAnimation.beginTime = beginTime;
    positionAnimation.additive = true;
    positionAnimation.calculationMode = kCAAnimationPaced;
    positionAnimation.rotationMode = kCAAnimationRotateAuto;
    positionAnimation.path = movePath.CGPath;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = false;
    positionAnimation.delegate = self;
    _cachePosition = self.position;
    // 小球变形动画, 小球变形实际上只是 Y 轴上的 Scale

    CAKeyframeAnimation *bubbleTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    bubbleTransformAnim.values   = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, _bubbleScale, 1)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    bubbleTransformAnim.keyTimes = @[@(0), @(0.5), @(1)];
    bubbleTransformAnim.duration = duration;
    bubbleTransformAnim.beginTime = beginTime;
    [_bubbleLayer addAnimation:bubbleTransformAnim forKey:@"Scale"];
    
    [self addAnimation:positionAnimation forKey:@"Position"];
    
    // 最后让小球鬼畜的抖动一下
    CAKeyframeAnimation *bubbleShakeAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    bubbleShakeAnim.beginTime = beginTime + duration + 0.05;
    bubbleShakeAnim.duration = 0.02;
    bubbleShakeAnim.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(0, 3)],[NSValue valueWithCGPoint:CGPointMake(0, -3)],[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    bubbleShakeAnim.repeatCount = 6;
    bubbleShakeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_bubbleLayer addAnimation:bubbleShakeAnim forKey:@"Shake"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAKeyframeAnimation *animate = (CAKeyframeAnimation *)anim;
    if ([animate isKindOfClass:[CAKeyframeAnimation class]]) {
        if ([animate.keyPath isEqualToString:@"position"]) {
            [self removeAnimationForKey:@"Position"];
            [CATransaction begin];
            [CATransaction setAnimationDuration:0];
            [CATransaction setDisableActions:true];
            CGPoint point = _cachePosition;
            point.x += (_styleConfig.smallBubbleSize + _styleConfig.bubbleXOffsetSpace) * (self.toLeft ? -1 : 1);
            self.position = point;
            self.opacity = 1;
            [CATransaction commit];
        }
    }
}

@end
