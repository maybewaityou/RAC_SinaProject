//
//  MPHomeStatusPhotoViews.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeStatusPhotoViews.h"
#import "MPHomeStatusPhotoView.h"
#import "Masonry.h"
#import "RACEXTScope.h"
#import "MPNMacros.h"
#import "SDPhotoBrowser.h"

@interface MPHomeStatusPhotoViews () <MPHomeStatusPhotoViewDelegate, SDPhotoBrowserDelegate>

@property (nonatomic, weak)MPHomeStatusPhotoView *photoView00;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView01;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView02;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView03;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView04;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView05;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView06;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView07;
@property (nonatomic, weak)MPHomeStatusPhotoView *photoView08;

@end

@implementation MPHomeStatusPhotoViews

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [self initPhotoViews];
    [self setupPhotoViews];
}

#pragma mark - 初始化图片控件
- (void)initPhotoViews
{
    MPHomeStatusPhotoView *photoView00 = [[MPHomeStatusPhotoView alloc] init];
    photoView00.onClickDelegate = self;
    photoView00.type = MPHomeStatusPhotoViewType00;
    [self addSubview:photoView00];
    self.photoView00 = photoView00;
    
    MPHomeStatusPhotoView *photoView01 = [[MPHomeStatusPhotoView alloc] init];
    photoView01.type = MPHomeStatusPhotoViewType01;
    photoView01.onClickDelegate = self;
    [self addSubview:photoView01];
    self.photoView01 = photoView01;
    
    MPHomeStatusPhotoView *photoView02 = [[MPHomeStatusPhotoView alloc] init];
    photoView02.type = MPHomeStatusPhotoViewType02;
    photoView02.onClickDelegate = self;
    [self addSubview:photoView02];
    self.photoView02 = photoView02;
    
    MPHomeStatusPhotoView *photoView03 = [[MPHomeStatusPhotoView alloc] init];
    photoView03.type = MPHomeStatusPhotoViewType03;
    photoView03.onClickDelegate = self;
    [self addSubview:photoView03];
    self.photoView03 = photoView03;
    
    MPHomeStatusPhotoView *photoView04 = [[MPHomeStatusPhotoView alloc] init];
    photoView04.type = MPHomeStatusPhotoViewType04;
    photoView04.onClickDelegate = self;
    [self addSubview:photoView04];
    self.photoView04 = photoView04;
    
    MPHomeStatusPhotoView *photoView05 = [[MPHomeStatusPhotoView alloc] init];
    photoView05.type = MPHomeStatusPhotoViewType05;
    photoView05.onClickDelegate = self;
    [self addSubview:photoView05];
    self.photoView05 = photoView05;
    
    MPHomeStatusPhotoView *photoView06 = [[MPHomeStatusPhotoView alloc] init];
    photoView06.type = MPHomeStatusPhotoViewType06;
    photoView06.onClickDelegate = self;
    [self addSubview:photoView06];
    self.photoView06 = photoView06;
    
    MPHomeStatusPhotoView *photoView07 = [[MPHomeStatusPhotoView alloc] init];
    photoView07.type = MPHomeStatusPhotoViewType07;
    photoView07.onClickDelegate = self;
    [self addSubview:photoView07];
    self.photoView07 = photoView07;
    
    MPHomeStatusPhotoView *photoView08 = [[MPHomeStatusPhotoView alloc] init];
    photoView08.type = MPHomeStatusPhotoViewType08;
    photoView08.onClickDelegate = self;
    [self addSubview:photoView08];
    self.photoView08 = photoView08;
}

#pragma mark - 设置图片控件
- (void)setupPhotoViews
{
    @weakify(self);
    [self.photoView00 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView00);
        make.left.equalTo(self.photoView00.mas_right).offset(margin10);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView02 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView00);
        make.left.equalTo(self.photoView01.mas_right).offset(margin10);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView03 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView00.mas_bottom).offset(margin10);
        make.left.equalTo(self.photoView00);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView04 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView03);
        make.left.equalTo(self.photoView03.mas_right).offset(margin10);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView05 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView03);
        make.left.equalTo(self.photoView04.mas_right).offset(margin10);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView06 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView03.mas_bottom).offset(margin10);
        make.left.equalTo(self.photoView00);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView07 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView06);
        make.left.equalTo(self.photoView06.mas_right).offset(margin10);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
    [self.photoView08 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.photoView06);
        make.left.equalTo(self.photoView07.mas_right).offset(margin10);
        make.width.equalTo(@MPStatusPhotoWH);
        make.height.equalTo(@MPStatusPhotoWH);
    }];
}

#pragma mark - 设置图片
- (void)setPhotos:(NSArray *)photos
{
    if (!photos) {
        for (int i=0; i<self.subviews.count; i++) {
            MPHomeStatusPhotoView *photoView = self.subviews[i];
            photoView.hidden = YES;
        }
        return;
    }
    
    _photos = photos;
    
    NSUInteger photoCount = photos.count;
    
    while (self.subviews.count < photoCount) {
        MPHomeStatusPhotoView *photoView = [[MPHomeStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    for (int i=0; i<self.subviews.count; i++) {
        MPHomeStatusPhotoView *photoView = self.subviews[i];
        if (i<photoCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}

#pragma mark - 代理方法（图片的点击事件）
- (void)onClick:(MPHomeStatusPhotoView *)photoView
{
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.sourceImagesContainerView = self; // 原图的父控件
    photoBrowser.imageCount = self.photos.count; // 图片总数
    photoBrowser.currentImageIndex = photoView.type;
    photoBrowser.delegate = self;
    [photoBrowser show];
}

#pragma mark - SDPhotoBrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return ((MPHomeStatusPhotoView *)self.subviews[index]).image;
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    // TODO 传入大图片的url地址
    NSString *urlStr = ((MPHomeStatusPhotoView *)self.subviews[index]).thumbnail_pic;
    return [NSURL URLWithString:urlStr];
}

@end
