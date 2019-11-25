//
//  TKrubberControl.h
//  TKRubberControl
//
//  Created by 李东岩 on 2019/11/22.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TKBubbleCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^valueChangeBlock)(NSInteger number);
@interface TKrubberControl : UIControl

@property (nonatomic,assign) NSInteger numberOfpage;

@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,copy) valueChangeBlock valueChange;

@property (nonatomic, strong) TKRubberPageControlConfig *styleConfig;

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count config:(TKRubberPageControlConfig *)config;

@end

NS_ASSUME_NONNULL_END
