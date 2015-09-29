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
        [self initialize];
    }
    return self;
}

#pragma mark - 初始化
- (void)initialize {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPhotoViewClick:)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
}

#pragma mark - 设置图片
- (void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    _thumbnail_pic = photo[@"thumbnail_pic"];
    [self sd_setImageWithURL:[NSURL URLWithString:_thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    self.gifImageView.hidden = ![_thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

#pragma mark - 懒加载
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

#pragma mark - 点击事件
- (void)onPhotoViewClick:(UITapGestureRecognizer *)recognizer
{
    if ([_onClickDelegate respondsToSelector:@selector(onClick:)]) {
        [_onClickDelegate onClick:self];
    }
}

@end
