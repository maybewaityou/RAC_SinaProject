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

@interface MPHomeStatusPhotoViews ()

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
        [self initPhotoViews];
        [self setupPhotoViews];
    }
    return self;
}

- (void)initPhotoViews
{
    MPHomeStatusPhotoView *photoView00 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView00];
    self.photoView00 = photoView00;
    
    MPHomeStatusPhotoView *photoView01 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView01];
    self.photoView01 = photoView01;
    
    MPHomeStatusPhotoView *photoView02 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView02];
    self.photoView02 = photoView02;
    
    MPHomeStatusPhotoView *photoView03 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView03];
    self.photoView03 = photoView03;
    
    MPHomeStatusPhotoView *photoView04 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView04];
    self.photoView04 = photoView04;
    
    MPHomeStatusPhotoView *photoView05 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView05];
    self.photoView05 = photoView05;
    
    MPHomeStatusPhotoView *photoView06 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView06];
    self.photoView06 = photoView06;
    
    MPHomeStatusPhotoView *photoView07 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView07];
    self.photoView07 = photoView07;
    
    MPHomeStatusPhotoView *photoView08 = [[MPHomeStatusPhotoView alloc] init];
    [self addSubview:photoView08];
    self.photoView08 = photoView08;
    
}

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

@end
