//
//  MPQRCodeUtils.h
//  CDemo
//
//  Created by ChunNan on 15/10/13.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MPQRCodeUtils : NSObject

+ (UIImage *)fetchQRCodeImageWithContentString:(NSString *)contentString;

@end
