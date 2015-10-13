//
//  MPQRCodeUtils.m
//  CDemo
//
//  Created by ChunNan on 15/10/13.
//  Copyright © 2015年 MeePwn. All rights reserved.
//

#import "MPQRCodeUtils.h"
#import <CoreImage/CoreImage.h>

@implementation MPQRCodeUtils

+ (UIImage *)fetchQRCodeImageWithContentString:(NSString *)contentString
{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *contentData = [contentString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:contentData forKey:@"inputMessage"];
    CIImage *outputImage = filter.outputImage;
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    
    return image;
}

@end
