//
//  UITextView+Extension.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
