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
#import "MPEmotionAttachment.h"

@interface MPEmotionTextView ()

@end

@implementation MPEmotionTextView

- (void)insertEmotion:(MPEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        MPEmotionAttachment *attach = [[MPEmotionAttachment alloc] init];
        attach.emotion = emotion;
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        NSAttributedString *imageAttach = [NSAttributedString attributedStringWithAttachment:attach];
        // 插入属性文字到光标位置
        [self insertAttributedText:imageAttach settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
    }
}

- (NSString *)allText
{
    NSMutableString *allString = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        MPEmotionAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {
            [allString appendString:attach.emotion.chs];
        }else{
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [allString appendString:str.string];
        }
    }];
    return [allString copy];
}

@end
