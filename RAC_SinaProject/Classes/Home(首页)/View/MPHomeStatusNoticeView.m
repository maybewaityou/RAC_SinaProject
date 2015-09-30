//
//  MPHomeStatusNoticeView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/1.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeStatusNoticeView.h"
#import "UIView+Extension.h"
#import "Masonry.h"

@interface MPHomeStatusNoticeView ()

@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) UIView *aboveView;
@property (nonatomic, strong) UIView *belowView;

@property (nonatomic, weak) UILabel *label;

@end

@implementation MPHomeStatusNoticeView

- (instancetype)initWithCount:(NSUInteger)count aboveView:(UIView *)aboveView belowView:(UIView *)belowView
{
    self = [super init];
    if (self) {
        _count = count;
        _aboveView = aboveView;
        _belowView = belowView;
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
        label.width = [UIScreen mainScreen].bounds.size.width;
        label.height = 35;
        
        if (self.count == 0) {
            label.text = @"没有新的微博数据，稍后再试";
        } else {
            label.text = [NSString stringWithFormat:@"共有%zd条新的微博数据", self.count];
        }
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        
        label.y = 64 - label.height;
        [self.aboveView insertSubview:label belowSubview:self.belowView];
        self.label = label;
    }
    return self;
}

- (void)show
{
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        self.label.transform = CGAffineTransformMakeTranslation(0, self.label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            self.label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self.label removeFromSuperview];
        }];
    }];

}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
