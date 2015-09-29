//
//  MPHomeStatusPhotoView.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPHomeStatusPhotoView;

typedef enum : NSInteger {
    MPHomeStatusPhotoViewType00,
    MPHomeStatusPhotoViewType01,
    MPHomeStatusPhotoViewType02,
    MPHomeStatusPhotoViewType03,
    MPHomeStatusPhotoViewType04,
    MPHomeStatusPhotoViewType05,
    MPHomeStatusPhotoViewType06,
    MPHomeStatusPhotoViewType07,
    MPHomeStatusPhotoViewType08
} MPHomeStatusPhotoViewType;

@protocol MPHomeStatusPhotoViewDelegate <NSObject>

- (void)onClick:(MPHomeStatusPhotoView *)photoView;

@end

@interface MPHomeStatusPhotoView : UIImageView

@property (nonatomic, copy)NSDictionary *photo;
@property (nonatomic, copy)NSString *thumbnail_pic;
@property (nonatomic, assign)MPHomeStatusPhotoViewType type;
@property (nonatomic, weak)id<MPHomeStatusPhotoViewDelegate> onClickDelegate;

@end
