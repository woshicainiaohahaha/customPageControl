//
//  TKrubberControl.m
//  TKRubberControl
//
//  Created by 李东岩 on 2019/11/22.
//  Copyright © 2019 李东岩. All rights reserved.
//

#import "TKrubberControl.h"

@interface TKrubberControl ()

@property (nonatomic, strong) UITapGestureRecognizer *indexTap;

@property (nonatomic, strong) NSMutableArray <TKBubbleCell *> *smallBubbles;

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;

@property (nonatomic, strong) CAShapeLayer *mainBubble;

@property (nonatomic, strong) CAShapeLayer *backLineLayer;

@property (nonatomic, assign) CGFloat bubbleScale;

@property (nonatomic, assign) CGFloat xPointbegin;

@property (nonatomic, assign) CGFloat xPointEnd;

@property (nonatomic, assign) CGFloat yPointbegin;

@property (nonatomic, assign) CGFloat yPointEnd;


@end

@implementation TKrubberControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame count:(NSInteger)count config:(TKRubberPageControlConfig *)config {
    if (self = [super initWithFrame:frame]) {
        _numberOfpage = count;
        _currentIndex = 0;
        _styleConfig = config;
        [self setUpView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        _currentIndex = 0;
        _styleConfig = [[TKRubberPageControlConfig alloc] init];
//        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    // 一些奇怪的位置计算
    
    CGFloat y = (self.bounds.size.height - (_styleConfig.smallBubbleSize + 2*_styleConfig.bubbleYOffsetSpace))/2;
    CGFloat w = (_numberOfpage - 2) * _styleConfig.smallBubbleSize + _styleConfig.mainBubbleSize + _numberOfpage * _styleConfig.bubbleXOffsetSpace;
    CGFloat h = _styleConfig.smallBubbleSize + _styleConfig.bubbleYOffsetSpace *2;
    CGFloat x = (self.bounds.size.width - w)/2;

    #if DEBUG
    if (w>self.bounds.size.width || h>self.bounds.size.height) {
        NSLog(@"⚠️⚠️⚠️ TKRubberPageControl size out of bounds ⚠️⚠️⚠️");
    }
    #endif
    
    _xPointbegin  = x;
    _xPointEnd    = x + w;
    _yPointbegin  = y;
    _yPointEnd    = y + h;

    CGRect lineFrame = CGRectMake(x, y, w, h);
    CGRect backBubblgFrame = CGRectMake(x, y-(_styleConfig.mainBubbleSize - h)/2, _styleConfig.mainBubbleSize, _styleConfig.mainBubbleSize);
    CGRect bigBubbleFrame = CGRectMake(x + _styleConfig.bubbleYOffsetSpace, y-(_styleConfig.mainBubbleSize - h)/2+_styleConfig.bubbleYOffsetSpace, _styleConfig.mainBubbleSize -2*_styleConfig.bubbleYOffsetSpace, _styleConfig.mainBubbleSize-2*_styleConfig.bubbleYOffsetSpace);

    // 背景的横线
    _backLineLayer = [CAShapeLayer layer];
    _backLineLayer.path = [UIBezierPath bezierPathWithRoundedRect:lineFrame cornerRadius:h/2].CGPath;
    _backLineLayer.fillColor = _styleConfig.backgroundColor.CGColor;
    _backLineLayer.frame = self.bounds;
    [self.layer addSublayer:_backLineLayer];

    // 大球背景的圈
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, backBubblgFrame.size.width, backBubblgFrame.size.height)].CGPath;
    _backgroundLayer.frame = backBubblgFrame;
    _backgroundLayer.fillColor = _styleConfig.backgroundColor.CGColor;
    _backgroundLayer.zPosition = -1;
    [self.layer addSublayer:_backgroundLayer];
    
    // 大球
    CGRect origin = bigBubbleFrame;
    _mainBubble = [CAShapeLayer layer];
    _mainBubble.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, bigBubbleFrame.size.width, bigBubbleFrame.size.height)].CGPath;
    _mainBubble.fillColor = _styleConfig.bigBubbleColor.CGColor;
    bigBubbleFrame.origin = origin.origin;
    _mainBubble.frame = bigBubbleFrame;
    _mainBubble.zPosition = 100;
    [self.layer addSublayer:_mainBubble];

    // 生成小球
    CGFloat bubbleOffset = _styleConfig.smallBubbleSize + _styleConfig.bubbleXOffsetSpace;
    CGRect bubbleFrame = CGRectMake(x + _styleConfig.bubbleXOffsetSpace + bubbleOffset, y + _styleConfig.bubbleYOffsetSpace, _styleConfig.smallBubbleSize, _styleConfig.smallBubbleSize);
    for (int i = 0; i<_numberOfpage-1; i++) {
        TKBubbleCell *smallBubble = [[TKBubbleCell alloc] initWithStyle:_styleConfig];
        smallBubble.frame = bubbleFrame;
        [self.layer addSublayer:smallBubble];
        [self.smallBubbles addObject:smallBubble];
        bubbleFrame.origin.x += bubbleOffset;
        smallBubble.zPosition = 1;
    }

    // 增加点击手势
    if (!_indexTap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        [self addGestureRecognizer:tap];
        _indexTap = tap;
    }
}

 // 重置控件

- (void)resetRubberIndicator {
    for (TKBubbleCell *cell in _smallBubbles) {
        [cell removeFromSuperlayer];
    }
    [_smallBubbles removeAllObjects];
    [self setUpView];
    [self setCurrentIndex:0 updateLayer:false];
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)ges {
    CGPoint location = [ges locationInView:self];

    if (location.y>_yPointbegin && location.y<_yPointEnd && location.x>_xPointbegin && location.x<_xPointEnd) {
        NSInteger index = (location.x - _xPointbegin)/_styleConfig.smallBubbleMoveRadius;
        [self setCurrentIndex:index updateLayer:YES];
    }

}

- (void)setNumberOfpage:(NSInteger)numberOfpage {
    _numberOfpage = 5;
    if (_numberOfpage != numberOfpage) {
        // TODO:
        //resetRubberIndicator
        _numberOfpage = numberOfpage;
        [self resetRubberIndicator];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = 0;
    if (_currentIndex != currentIndex) {
        //setCurrentIndex
        [self setCurrentIndex:0 updateLayer:false];
    }
}

- (void) setStyleConfig:(TKRubberPageControlConfig *)styleConfig {
    //resetRubberIndicator
    _styleConfig = [[TKRubberPageControlConfig alloc] initWithSmallBubbleSize:16.f withMainBubbleSize:40.f withBubbleXOffsetSpace:12.f withBubbleYOffsetSpace:8.f withAnimationDuration:.2f withBackgroundColor:[UIColor colorWithDisplayP3Red:0.357 green:0.196 blue:0.337 alpha:1] withSmallBubbleColor:[UIColor colorWithRed:0.961 green:0.561 blue:0.518 alpha:1] withBigBubbleColor:[UIColor colorWithRed:0.788 green:0.216 blue:0.337 alpha:1]];
    if (_styleConfig != styleConfig) {
        _styleConfig = styleConfig;
    }
    [self resetRubberIndicator];
}

- (void)setCurrentIndex:(NSInteger)newIndex updateLayer:(BOOL)updateLayer {
    NSInteger index = MAX(0, MIN(newIndex, _numberOfpage-1));
    if (index == _currentIndex) {
        return;
    }
    
    if (updateLayer) {
        TKMoveDirection direction = (_currentIndex > index) ? right : left;
        if (_currentIndex < index) {
            for (int x= 0; x<index-_currentIndex; x++) {
                TKBubbleCell *smallBubble = self.smallBubbles[index-x-1];
                [smallBubble positionChange:direction radius:_styleConfig.smallBubbleMoveRadius/2 duration:_styleConfig.animationDuration beginTime:CACurrentMediaTime()];
            }
        } else {
            for (int x= 0; x<_currentIndex-index; x++) {
                TKBubbleCell *smallBubble = self.smallBubbles[_currentIndex-x-1];
                [smallBubble positionChange:direction radius:_styleConfig.smallBubbleMoveRadius/2 duration:_styleConfig.animationDuration beginTime:CACurrentMediaTime()];
            }
        }
        // 大球缩放动画
        CAKeyframeAnimation *bubbleTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        bubbleTransformAnim.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],[NSValue valueWithCATransform3D:CATransform3DMakeScale(_bubbleScale, _bubbleScale, 1)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        bubbleTransformAnim.keyTimes = @[@(0),@(0.5),@(1)];
        bubbleTransformAnim.duration = _styleConfig.animationDuration;
        
        // 大球移动动画, 用隐式动画大球的位置会真正的改变
        [CATransaction begin];
        [CATransaction setAnimationDuration:_styleConfig.animationDuration];
        CGFloat x = _xPointbegin + _styleConfig.smallBubbleMoveRadius*index + _styleConfig.mainBubbleSize/2;
        
        CGPoint main_position = _mainBubble.position;
        main_position.x = x;
        _mainBubble.position = main_position;
        
        CGPoint back_position = _backgroundLayer.position;
        back_position.x = x;
        _backgroundLayer.position = back_position;
        
        [CATransaction commit];
        [_mainBubble addAnimation:bubbleTransformAnim forKey:@"Scale"];
    }

    // 变更`currentIndex`
    _currentIndex = index;
    // 可以使用 Target-Action 监听事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    if (_valueChange) {
        _valueChange(_currentIndex);
    }
}

- (NSMutableArray *)smallBubbles {
    if (!_smallBubbles) {
        _smallBubbles = [NSMutableArray array];
    }
    return _smallBubbles;
}

@end
