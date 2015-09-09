//
//  MPComposeToolbar.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/10.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPComposeToolbar.h"
#import "UIView+Extension.h"

@interface MPComposeToolbar ()

@end

@implementation MPComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        [self setupViews];
    }
    return self;
}

- (void)initViews
{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]]];
    
    [self setupButtonsWithImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted"];
    [self setupButtonsWithImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted"];
    [self setupButtonsWithImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted"];
    [self setupButtonsWithImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted"];
    [self setupButtonsWithImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted"];
}

- (void)setupViews
{
    NSUInteger count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    
    for (NSUInteger i=0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.x = buttonW * i;
        button.width = buttonW;
        button.height = buttonH;
    }
}

- (void)setupButtonsWithImage:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

@end
