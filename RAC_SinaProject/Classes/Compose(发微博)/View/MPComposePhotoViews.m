//
//  MPComposePhotoViews.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/11.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPComposePhotoViews.h"
#import "UIView+Extension.h"

@interface MPComposePhotoViews ()

@property (nonatomic, copy)NSMutableArray *photosM;

@end

@implementation MPComposePhotoViews

- (NSMutableArray *)photosM
{
    if (!_photosM) {
        _photosM = [NSMutableArray array];
    }
    return _photosM;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    
    [self.photosM addObject:image];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    NSUInteger maxCol = 4;
    CGFloat margin10 = 10;
    CGFloat photoViewWH = (self.width - 3 * margin10) / 4.0;
    for (NSUInteger i = 0; i < count; i++) {
        UIImageView *photoView = self.subviews[i];
        NSUInteger col = i % maxCol;
        photoView.x = col * (photoViewWH + margin10);
        NSUInteger row = i / maxCol;
        photoView.y = row * (photoViewWH + margin10);
        photoView.width = photoViewWH;
        photoView.height = photoViewWH;
    }
}

- (NSArray *)photos
{
    return [self.photosM copy];
}

@end
