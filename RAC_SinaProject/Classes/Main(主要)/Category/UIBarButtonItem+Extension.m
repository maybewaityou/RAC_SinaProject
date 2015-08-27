//
//  UIBarButtonItem+Extension.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "ReactiveCocoa.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage onClickListener:(onClickListener) onClickListener;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         onClickListener(x);
    }];
    
    button.size = button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
