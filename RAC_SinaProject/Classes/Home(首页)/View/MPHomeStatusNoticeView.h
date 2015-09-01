//
//  MPHomeStatusNoticeView.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/1.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPHomeStatusNoticeView : UIView

- (instancetype)initWithCount:(NSUInteger)count aboveView:(UIView *)aboveView belowView:(UIView *)belowView;

- (void)show;

@end
