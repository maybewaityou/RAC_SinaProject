//
//  MPHomeStatusCell.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/28.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPHomeStatusCell.h"
#import "Status.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "ReactiveCocoa.h"

@interface MPHomeStatusCell ()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *statusLabel;
@property (nonatomic, strong)UIImageView *userImageView;

@end

@implementation MPHomeStatusCell

- (void)bindViewModel:(id)viewModel
{
    Status *status = (Status *)viewModel;
    self.nameLabel.text = status.user.name;
    self.statusLabel.text = status.text;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url]];
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
        @weakify(self);
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.userImageView);
            make.left.equalTo(self.userImageView).offset(10);
            make.right.equalTo(self);
        }];
    }
    return _nameLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        [self addSubview:_statusLabel];
        @weakify(self);
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.nameLabel);
            make.left.equalTo(self.nameLabel);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return  _statusLabel;
}

- (UIImageView *)userImageView
{
    if (!_userImageView) {
        UIImage *image = [UIImage imageNamed:@"avatar_default"];
        _userImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_userImageView];
        @weakify(self);
        [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.width.equalTo(@(30));
            make.height.equalTo(@(30));
        }];
    }
    return _userImageView;
}

@end
