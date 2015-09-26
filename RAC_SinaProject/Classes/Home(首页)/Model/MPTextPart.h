//
//  MPTextPart.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/27.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPTextPart : NSObject

@property (nonatomic, copy)NSString *text;
@property (nonatomic, assign)NSRange range;
@property (nonatomic, assign, getter=isSpecial)BOOL special;
@property (nonatomic, assign, getter=isEmotion)BOOL emotion;

@end
