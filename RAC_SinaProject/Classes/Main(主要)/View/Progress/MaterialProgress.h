//
//  MaterialProgress.h
//  SpinnerDemo
//
//  Created by ChunNan on 15/6/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaterialProgress;

@protocol MaterialProgressDelete <NSObject>

@optional
- (void)onBlurClick:(UIButton *)button;

@end

@interface MaterialProgress : UIView

@property (weak, nonatomic) id<MaterialProgressDelete> blurDelete;

+ (instancetype) sharedMaterialProgress;

- (void)show;
- (void)dismiss;

@end
