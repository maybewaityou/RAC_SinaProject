//
//  MPComposePhotoViews.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/11.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPComposePhotoViews : UIView

@property (nonatomic, copy, readonly) NSArray *photos;

- (void)addImage:(UIImage *)image;

@end
