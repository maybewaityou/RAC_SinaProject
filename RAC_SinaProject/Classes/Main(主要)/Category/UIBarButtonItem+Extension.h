//
//  UIBarButtonItem+Extension.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^onClickListener)(UIView *view);

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage onClickListener:(onClickListener) onClickListener;

@end
