//
//  MPEmotionTabBarButton.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/17.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionTabBarButton.h"

@implementation MPEmotionTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
