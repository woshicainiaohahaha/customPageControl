# customPageControl
a animal pageControl with Objective-C.

# 一个动画pagecontrol
这个灵感来自一个作者[TKRubberIndicator](https://github.com/TBXark/TKRubberIndicator)，但是由于原作者使用swift语言，对于OC项目使用并不方便。我经过翻译后，目前可以正常使用。

## 效果如下
![GIF图](https://github.com/TBXark/TKRubberIndicator/blob/master/Example/demo.gif)

# 如何使用

1. 下载文件，引入项目，然后，导入头文件

```
#import "TKrubberControl.h"
```

2. 初始化
```
    TKrubberControl *page = [[TKrubberControl alloc] initWithFrame:CGRectMake(100, 100, 200, 100) count:5 config:     [[TKRubberPageControlConfig alloc] init]];
    page.center =  self.view.center;
    
    page.valueChange = ^(NSInteger number) { //number 第几页
        NSLog(@"number-----%ld",number);
    };
    
    [self.view addSubview:page];
```
