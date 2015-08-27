//
//  MaterialProgress.m
//  SpinnerDemo
//
//  Created by ChunNan on 15/6/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MaterialProgress.h"
#import "MMMaterialDesignSpinner.h"
#import "ReactiveCocoa.h"
#import "MPNMacros.h"
#import "UIColor+Extension.h"

@interface MaterialProgress ()
@property (strong, nonatomic) UIButton *blur;
@property (strong, nonatomic) MMMaterialDesignSpinner *spinner;
@property (strong, nonatomic) UIView *spinnerBackgroundView;

@end

@implementation MaterialProgress

- (UIButton *)blur
{
    if (!_blur) {
        _blur = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _blur.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _blur.backgroundColor = [UIColor blackColor];
        _blur.alpha = 0.0f;
        [_blur addTarget:self action:@selector(onBlurClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_blur];
    }
    return _blur;
}

- (UIView *)spinnerBackgroundView
{
    if (!_spinnerBackgroundView) {
        _spinnerBackgroundView                 = [[UIView alloc] init];
        _spinnerBackgroundView.center          = CGPointMake(SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/2.0f);
        _spinnerBackgroundView.bounds          = CGRectMake(0, 0, SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/5.0f);
        _spinnerBackgroundView.backgroundColor = [UIColor blackColor];
        _spinnerBackgroundView.alpha           = 0.0f;
        
    }
    return _spinnerBackgroundView;
}

- (MMMaterialDesignSpinner *)spinner
{
    if (!_spinner) {
        _spinner = [[MMMaterialDesignSpinner alloc] init];
        _spinner.lineWidth                = 4;
        _spinner.alpha                    = 0.0f;
        _spinner.bounds                   = CGRectMake(0, 0,self.spinnerBackgroundView.bounds.size.height/2.5f, self.spinnerBackgroundView.bounds.size.height/2.5f);
        _spinner.center                   = CGPointMake(SCREEN_WIDTH/2.0f, SCREEN_HEIGHT/2.0f);
        _spinner.tintColor                = [UIColor colorWithHexString:@"#FF9200"];
    }
    return _spinner;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.blur];
        [self addSubview:self.spinnerBackgroundView];
        [self addSubview:self.spinner];
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        [window addSubview:self];
    }
    return self;
}

- (void)setBlurDelete:(id<MaterialProgressDelete>)blurDelete
{
    _blurDelete = blurDelete;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    [UIView animateWithDuration:0.25f animations:^{
        self.blur.alpha= 0.5f;
        self.spinner.alpha= 1.0f;
        self.spinnerBackgroundView.alpha= 1.0f;
        [self.spinner startAnimating];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25f animations:^{
        self.blur.alpha= 0.0f;
        self.spinner.alpha= 0.0f;
        self.spinnerBackgroundView.alpha= 0.0f;
        [self.spinner stopAnimating];
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)onBlurClick:(UIButton *)button
{
    [self dismiss];
    if ([_blurDelete respondsToSelector:@selector(onBlurClick:)]) {
        [_blurDelete onBlurClick:button];
    }
}

+ (instancetype) sharedMaterialProgress
{
    static dispatch_once_t onceToken;
    __strong static MaterialProgress *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return instance;
}

@end
