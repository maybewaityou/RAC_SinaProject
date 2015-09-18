//
//  UITextView+Extension.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributeText:(NSAttributedString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    [attributedText appendAttributedString:self.attributedText];
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];
    
    self.attributedText = attributedText;
    
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

@end
