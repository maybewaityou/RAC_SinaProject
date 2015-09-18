//
//  MPEmotionTextView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/18.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionTextView.h"
#import "MPEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"

@interface MPEmotionTextView ()

@end

@implementation MPEmotionTextView

- (void)insertEmotion:(MPEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:emotion.png];
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        NSAttributedString *imageAttach = [NSAttributedString attributedStringWithAttachment:attach];
        [self insertAttributeText:imageAttach];
        
        // 设置字体
//        NSAttributedString *text = self.attributedText;
//        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithAttributedString:text];
//        NSRange range = NSMakeRange(0, text.length);
//        [textString addAttribute:NSFontAttributeName value:self.font range:range];

    }
}

@end
