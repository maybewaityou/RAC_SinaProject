//
//  MPTabBar.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/9.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPTabBar.h"
#import "Masonry.h"
#import "UIView+Extension.h"

@interface MPTabBar ()

@property (nonatomic, weak)UIButton *writeStatusButton;

@end

@implementation MPTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    UIButton *writeStatusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [writeStatusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [writeStatusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [writeStatusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [writeStatusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    writeStatusButton.size = writeStatusButton.currentBackgroundImage.size;
    [self addSubview:writeStatusButton];
    self.writeStatusButton = writeStatusButton;
    [writeStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    self.onPlusClickSignal = [writeStatusButton rac_signalForControlEvents:UIControlEventTouchUpInside];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *childView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:class]) {
            // 设置宽度
            childView.width = tabBarButtonW;
            // 设置x
            childView.x = tabBarButtonIndex * tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }

        }
    }
}

@end
