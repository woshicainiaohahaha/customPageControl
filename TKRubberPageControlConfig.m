//
//  TKRubberPageControlConfig.m
//  TKRubberControl
//
//  Created by 李东岩 on 2019/11/22.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import "TKRubberPageControlConfig.h"

@implementation TKRubberPageControlConfig

- (id) init {
    if (self = [super init]) {
        
    }
    return [self initWithSmallBubbleSize:16.f withMainBubbleSize:40.f withBubbleXOffsetSpace:12.f withBubbleYOffsetSpace:8.f withAnimationDuration:.2f withBackgroundColor:[UIColor colorWithDisplayP3Red:0.357 green:0.196 blue:0.337 alpha:1] withSmallBubbleColor:[UIColor colorWithRed:0.961 green:0.561 blue:0.518 alpha:1] withBigBubbleColor:[UIColor colorWithRed:0.788 green:0.216 blue:0.337 alpha:1]];
}

- (id) initWithSmallBubbleSize:(CGFloat)smallBubbleSize withMainBubbleSize:(CGFloat)mainBubbleSize withBubbleXOffsetSpace:(CGFloat)bubbleXOffsetSpace withBubbleYOffsetSpace:(CGFloat)bubbleYOffsetSpace withAnimationDuration:(CFTimeInterval)animationDuration withBackgroundColor:(UIColor *)backgroundColor withSmallBubbleColor:(UIColor *)smallBubbleColor withBigBubbleColor:(UIColor *)bigBubbleColor {
    if (self = [super init]) {
        self.smallBubbleSize = smallBubbleSize;
        self.mainBubbleSize = mainBubbleSize;
        self.bubbleXOffsetSpace = bubbleXOffsetSpace;
        self.bubbleYOffsetSpace = bubbleYOffsetSpace;
        self.animationDuration = animationDuration;
        self.backgroundColor = backgroundColor;
        self.smallBubbleColor = smallBubbleColor;
        self.bigBubbleColor = bigBubbleColor;
    }
    return self;
}

- (CGFloat)smallBubbleMoveRadius {
    return self.smallBubbleSize + self.bubbleXOffsetSpace;
}

@end
