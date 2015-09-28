//
//  MPHomeStatusPhotoView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeStatusPhotoView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface MPHomeStatusPhotoView ()

@property (nonatomic, weak)UIImageView *gifImageView;

@end

@implementation MPHomeStatusPhotoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    NSString *thumbnail_pic = photo[@"thumbnail_pic"];
    [self sd_setImageWithURL:[NSURL URLWithString:thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    self.gifImageView.hidden = ![thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (UIImageView *)gifImageView
{
    if (!_gifImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:imageView];
        self.gifImageView = imageView;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
        }];
    }
    return _gifImageView;
}

@end
