//
//  MPComposeToolbar.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/10.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPComposeToolbar.h"
#import "UIView+Extension.h"
#import "Masonry.h"

@interface MPComposeToolbar ()

@property (nonatomic, weak)UIButton *cameraButton;
@property (nonatomic, weak)UIButton *pictureButton;
@property (nonatomic, weak)UIButton *mentionButton;
@property (nonatomic, weak)UIButton *trendButton;
@property (nonatomic, weak)UIButton *emoticonButton;

@end

@implementation MPComposeToolbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupViews];
}

- (void)initViews
{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]]];
    
    self.cameraButton = [self setupButtonsWithImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted"];
    self.pictureButton = [self setupButtonsWithImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted"];
    self.mentionButton = [self setupButtonsWithImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted"];
    self.trendButton = [self setupButtonsWithImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted"];
    self.emoticonButton = [self setupButtonsWithImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted"];
    

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

- (UIButton *)setupButtonsWithImage:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [self addSubview:button];

    return button;
}


@end
