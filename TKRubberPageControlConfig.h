//
//  TKRubberPageControlConfig.h
//  TKRubberControl
//
//  Created by 李东岩 on 2019/11/22.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKRubberPageControlConfig : NSObject

@property (nonatomic,assign) CGFloat smallBubbleSize;

@property (nonatomic,assign) CGFloat mainBubbleSize;

@property (nonatomic,assign) CGFloat bubbleXOffsetSpace;

@property (nonatomic,assign) CGFloat bubbleYOffsetSpace;

@property (nonatomic,assign) CFTimeInterval animationDuration;

@property (nonatomic,assign) CGFloat smallBubbleMoveRadius;

@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,strong) UIColor *smallBubbleColor;

@property (nonatomic,strong) UIColor *bigBubbleColor;

//public init(smallBubbleSize: CGFloat = 16,
//            mainBubbleSize: CGFloat = 40,
//            bubbleXOffsetSpace: CGFloat = 12,
//            bubbleYOffsetSpace: CGFloat = 8,
//            animationDuration: CFTimeInterval = 0.2,
//            backgroundColor: UIColor = UIColor(red: 0.357, green: 0.196, blue: 0.337, alpha: 1.000),
//            smallBubbleColor: UIColor = UIColor(red: 0.961, green: 0.561, blue: 0.518, alpha: 1.000),
//            bigBubbleColor: UIColor = UIColor(red: 0.788, green: 0.216, blue: 0.337, alpha: 1.000)) {

- (id) initWithSmallBubbleSize:(CGFloat)smallBubbleSize withMainBubbleSize:(CGFloat)mainBubbleSize withBubbleXOffsetSpace:(CGFloat)bubbleXOffsetSpace withBubbleYOffsetSpace:(CGFloat)bubbleYOffsetSpace withAnimationDuration:(CFTimeInterval)animationDuration withBackgroundColor:(UIColor *)backgroundColor withSmallBubbleColor:(UIColor *)smallBubbleColor withBigBubbleColor:(UIColor *)bigBubbleColor;

@end

NS_ASSUME_NONNULL_END
