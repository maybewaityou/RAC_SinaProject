//
//  MPHomeStatusToolbar.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/7.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeStatusToolbar.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "UIView+Extension.h"

@interface MPHomeStatusToolbar ()

@property (nonatomic, strong)NSMutableArray *buttons;
@property (nonatomic, strong)NSMutableArray *dividers;

@property (nonatomic, weak)UIButton *repostButton;
@property (nonatomic, weak)UIButton *commentButton;
@property (nonatomic, weak)UIButton *attitudeButton;

@end

@implementation MPHomeStatusToolbar

+ (instancetype)toolbar
{
    return [[self alloc] init];
}

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
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
    
    self.repostButton = [self setupButtonsWithTitle:@"转发" icon:@"timeline_icon_retweet"];
    self.commentButton = [self setupButtonsWithTitle:@"评论" icon:@"timeline_icon_comment"];
    self.attitudeButton = [self setupButtonsWithTitle:@"赞" icon:@"timeline_icon_unlike"];
    
    CGFloat defaultW = [UIScreen mainScreen].bounds.size.width/3;
    CGFloat defaultH = 35;
    
    @weakify(self);
    [self.repostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(@(defaultW));
        make.height.equalTo(@(defaultH));
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.repostButton);
        make.left.equalTo(self.repostButton.mas_right);
        make.width.equalTo(@(defaultW));
        make.height.equalTo(@(defaultH));
    }];
    [self.attitudeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.repostButton);
        make.left.equalTo(self.commentButton.mas_right);
        make.width.equalTo(@(defaultW));
        make.height.equalTo(@(defaultH));
    }];
}

- (UIButton *)setupButtonsWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:button];
    
    [self.buttons addObject:button];
    
    return button;
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

@end
