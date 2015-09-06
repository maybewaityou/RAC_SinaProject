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
#import "MPHomeCellViewModel.h"
#import "User.h"
#import "UIView+Extension.h"

@interface MPHomeStatusCell ()

/**
 *  原创微博
 */
@property (nonatomic, weak)UIView *originalView;
@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UILabel *timeLabel;
@property (nonatomic, weak)UILabel *sourceLabel;
@property (nonatomic, weak)UILabel *statusLabel;
@property (nonatomic, weak)UIImageView *userImageView;
@property (nonatomic, weak)UIImageView *vipImageView;
@property (nonatomic, weak)UIImageView *photoImageView;

@property (nonatomic, strong)MPHomeCellViewModel *viewModel;

@end

@implementation MPHomeStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
        [self setupViews];
    }
    return self;
}

- (void)initViews
{
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    UIImage *image = [UIImage imageNamed:@"avatar_default"];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:image];
    [self.originalView addSubview:userImageView];
    self.userImageView = userImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *vipImageView = [[UIImageView alloc] init];
    vipImageView.contentMode = UIViewContentModeCenter;
    [self.originalView addSubview:vipImageView];
    self.vipImageView = vipImageView;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:14.0];
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = [UIFont systemFontOfSize:14.0];
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;

    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.numberOfLines = 0;
    statusLabel.font = [UIFont systemFontOfSize:13.0];
    [self.originalView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UIImageView *photoImageView = [[UIImageView alloc] init];
    [self.originalView addSubview:photoImageView];
    self.photoImageView = photoImageView;

    
}

- (void)setupViews
{
    NSInteger margin5 = 5;
    NSInteger margin10 = 10;
    NSInteger defaultW = 50;
    NSInteger defaultH = 50;
    
    @weakify(self);
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.originalView).offset(margin10);
        make.left.equalTo(self.originalView).offset(margin10);
        make.width.equalTo(@(defaultW));
        make.height.equalTo(@(defaultH));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView);
        make.left.equalTo(self.userImageView.mas_right).offset(margin10);
    }];
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(margin5);
        make.bottom.equalTo(self.nameLabel);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(margin5);
        make.left.equalTo(self.userImageView.mas_right).offset(margin10);
    }];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.timeLabel);
        make.left.equalTo(self.timeLabel.mas_right).offset(margin5);
        make.right.equalTo(self.statusLabel);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView.mas_bottom).offset(margin10);
        make.left.equalTo(self.userImageView);
        make.right.equalTo(self.originalView).offset(-margin10);
    }];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(margin5);
        make.left.equalTo(self.userImageView);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    [self.originalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView).offset(-margin10);
        make.left.equalTo(self.userImageView).offset(-margin10);
        make.bottom.equalTo(self.photoImageView).offset(margin10);
        make.width.equalTo(self.mas_width);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.originalView);
    }];
}

- (void)bindViewModel:(id)viewModel
{
    Status *status = (Status *)viewModel;
    User *user = status.user;
    self.viewModel.status = status;
    self.nameLabel.text = status.user.name;
    self.statusLabel.text = status.text;
    self.timeLabel.text = status.created_at;
    self.sourceLabel.text = status.source;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    
    if (user.isVip) {
        self.vipImageView.hidden = NO;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipImageView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else {
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    if (status.pic_urls.count) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:status.pic_urls[0][@"thumbnail_pic"]]];
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@100);
        }];
    }else {
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    [self.rac_prepareForReuseSignal subscribeNext:^(id x) {
        self.viewModel = nil;
    }];
}

- (MPHomeCellViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[MPHomeCellViewModel alloc] init];
    }
    return _viewModel;
}

#if 0

// If you are not using auto layout, override this method
- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.nameLabel sizeThatFits:size].height;
    totalHeight += [self.statusLabel sizeThatFits:size].height;
    totalHeight += [self.userImageView sizeThatFits:size].height;
    totalHeight += 40; // margins
    return CGSizeMake(size.width, totalHeight);
}

#endif

@end
