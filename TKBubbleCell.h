//
//  TKBubbleCell.h
//  TKRubberControl
//
//  Created by 李东岩 on 2019/11/22.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "TKRubberPageControlConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TKMoveDirection) {
    left,
    right
};

@interface TKBubbleCell : CAShapeLayer <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *bubbleLayer;
@property (nonatomic, assign) CGFloat bubbleScale;
@property (nonatomic, strong) TKRubberPageControlConfig *styleConfig;

@property (nonatomic, assign) TKMoveDirection lastDirection;

@property (nonatomic, assign) CGPoint cachePosition;

@property (nonatomic, assign) BOOL toLeft;

- (id)initWithStyle:(TKRubberPageControlConfig *)style;

- (void)positionChange:(TKMoveDirection)direction radius:(CGFloat)radius duration:(CFTimeInterval)duration beginTime:(CFTimeInterval)beginTime;

@end

NS_ASSUME_NONNULL_END
