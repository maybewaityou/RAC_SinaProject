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
#import "ReactiveCocoa.h"
#import "MPHomeCellViewModel.h"
#import "User.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "MPHomeStatusPhotoViews.h"
#import "MPUserIconView.h"
#import "MPMacros.h"

@interface MPHomeStatusCell ()

#pragma mark - 原创微博控件
/**
 *  原创微博
 */
@property (nonatomic, weak) UIView *originalView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) MPUserIconView *userImageView;
@property (nonatomic, weak) UIImageView *vipImageView;
@property (nonatomic, weak) MPHomeStatusPhotoViews *photoImageView;

#pragma mark - 转发微博控件
/**
 *  转发微博
 */
@property (nonatomic, weak) UIView *retweetView;
@property (nonatomic, weak) UILabel *retweetContentView;
@property (nonatomic, weak) MPHomeStatusPhotoViews *retweetPhotoImageView;

#pragma mark - 转发、评论、赞控件
/**
 *  转发、评论、赞
 */
@property (nonatomic, weak) UIView *toolBar;
@property (nonatomic, weak) UIButton *repostButton;
@property (nonatomic, weak) UIButton *commentButton;
@property (nonatomic, weak) UIButton *attitudeButton;
@property (nonatomic, weak) UIImageView *dividerLeft;
@property (nonatomic, weak) UIImageView *dividerRight;

#pragma mark - ViewModel
/**
 *  ViewModel
 */
@property (nonatomic, strong) MPHomeCellViewModel *viewModel;

@end

@implementation MPHomeStatusCell

#pragma mark - 初始化方法
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
    // 原创微博
    [self initOriginalStatusViews];

    // 转发微博
    [self initRepostStatusViews];
    
    // 转发、评论、赞
    [self initStatusToolbar];
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
}

- (void)setupViews
{
    // 原创微博
    [self setupOriginalStatusViews];
    
    // 转发微博
    [self setupRepostStatusViews];
    
    // 转发、评论、赞
    [self setupStatusToolbar];

    @weakify(self);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.left.right.equalTo(self.originalView);
        make.bottom.equalTo(self.toolBar).offset(margin10);
    }];
    
}

#pragma mark - 初始化控件
- (void)initOriginalStatusViews
{
    // 原创微博
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    UIImage *image = [UIImage imageNamed:@"avatar_default"];
    MPUserIconView *userImageView = [[MPUserIconView alloc] initWithImage:image];
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
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:13.0];
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.textColor = [UIColor lightGrayColor];
    sourceLabel.font = [UIFont systemFontOfSize:13.0];
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.numberOfLines = 0;
    statusLabel.font = [UIFont systemFontOfSize:14.0];
    [self.originalView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    MPHomeStatusPhotoViews *photoImageView = [[MPHomeStatusPhotoViews alloc] init];
    [self.originalView addSubview:photoImageView];
    self.photoImageView = photoImageView;
}

- (void)initRepostStatusViews
{
    // 转发微博
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentView = [[UILabel alloc] init];
    retweetContentView.font = [UIFont systemFontOfSize:14.0];
    retweetContentView.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentView];
    self.retweetContentView = retweetContentView;
    
    MPHomeStatusPhotoViews *retweetPhotoImageView = [[MPHomeStatusPhotoViews alloc] init];
    [self.retweetView addSubview:retweetPhotoImageView];
    self.retweetPhotoImageView = retweetPhotoImageView;
}

- (void)initStatusToolbar
{
    UIView *toolBar = [[UIView alloc] init];
    toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
    
    self.repostButton = [self setupButtonsWithTitle:@"转发" icon:@"timeline_icon_retweet"];
    self.commentButton = [self setupButtonsWithTitle:@"评论" icon:@"timeline_icon_comment"];
    self.attitudeButton = [self setupButtonsWithTitle:@"赞" icon:@"timeline_icon_unlike"];
    
    UIImageView *dividerLeft = [[UIImageView alloc] init];
    dividerLeft.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [toolBar addSubview:dividerLeft];
    self.dividerLeft = dividerLeft;
    
    UIImageView *dividerRight = [[UIImageView alloc] init];
    dividerRight.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [toolBar addSubview:dividerRight];
    self.dividerRight = dividerRight;
}

#pragma mark - 设置控件
- (void)setupOriginalStatusViews
{
    // 原创微博
    @weakify(self);
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(margin10);
        make.left.equalTo(self).offset(margin10);
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
        make.width.equalTo(@(80));
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
        make.top.equalTo(self.statusLabel.mas_bottom).offset(margin10);
        make.left.equalTo(self.userImageView);
        make.width.equalTo(@(MPStatusPhotoWH * 3 + margin10 * 2));
    }];
    [self.originalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView).offset(-margin10);
        make.left.equalTo(self.userImageView).offset(-margin10);
        make.bottom.equalTo(self.photoImageView).offset(margin10);
        make.width.equalTo(@SCREEN_WIDTH);
    }];
}

- (void)setupRepostStatusViews
{
    // 转发微博
    @weakify(self);
    [self.retweetView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.originalView.mas_bottom);
        make.left.right.equalTo(self.originalView);
        make.bottom.equalTo(self.retweetPhotoImageView).offset(margin10);
    }];
    [self.retweetContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.retweetView).offset(margin10);
        make.left.equalTo(self.retweetView).offset(margin10);
        make.right.equalTo(self.retweetView).offset(-margin10);
    }];
    [self.retweetPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.retweetContentView.mas_bottom).offset(margin10);
        make.left.equalTo(self.retweetContentView);
        make.width.equalTo(@(MPStatusPhotoWH * 3 + margin10 * 2));
    }];
}

- (void)setupStatusToolbar
{
    CGFloat toolBarDefaultW = [UIScreen mainScreen].bounds.size.width/3;
    CGFloat toolBarDefaultH = 35;
    
    @weakify(self);
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.retweetView.mas_bottom);
        make.left.right.equalTo(self.retweetView);
        make.height.equalTo(@35);
    }];
    
    [self.repostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.toolBar);
        make.left.equalTo(self.toolBar);
        make.width.equalTo(@(toolBarDefaultW));
        make.height.equalTo(@(toolBarDefaultH));
    }];
    [self.dividerLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.repostButton.mas_right).offset(-0.5);
        make.centerY.equalTo(self.toolBar);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.repostButton);
        make.left.equalTo(self.repostButton.mas_right);
        make.width.equalTo(@(toolBarDefaultW));
        make.height.equalTo(@(toolBarDefaultH));
    }];
    [self.dividerRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentButton.mas_right).offset(-0.5);
        make.centerY.equalTo(self.toolBar);
    }];
    [self.attitudeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.repostButton);
        make.left.equalTo(self.commentButton.mas_right);
        make.width.equalTo(@(toolBarDefaultW));
        make.height.equalTo(@(toolBarDefaultH));
    }];

}

#pragma mark - 绑定控件
- (void)bindViewModel:(id)viewModel
{
    Status *status = (Status *)viewModel;
    User *user = status.user;
    self.viewModel.status = status;
    self.nameLabel.text = status.user.name;
    self.statusLabel.attributedText = status.attributedText;
    self.timeLabel.text = status.created_at;
    self.sourceLabel.text = status.source;
    self.userImageView.user = user;
    [self setupStatusToolBarWithStatus:status];
    
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
        self.photoImageView.photos = status.pic_urls;
        [self setupPhotoViewHeight:status.pic_urls.count];
    }else {
        self.photoImageView.photos = nil;
        [self setupPhotoViewHeight:0];
    }
    
    if (status.retweeted_status) {
        Status *retweetStatus = status.retweeted_status;
        /** 被转发的微博正文 */
        self.retweetContentView.attributedText = status.retweetedAttributedText;
        
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotoImageView.photos = retweetStatus.pic_urls;
            [self retweetContentViewHiddenTopConstrain:NO];
            [self setupRetweetPhotoViewHeight:retweetStatus.pic_urls.count];
            [self retweetViewHiddenTopConstrain:NO];
        }else{
            self.retweetPhotoImageView.photos = nil;
            [self retweetContentViewHiddenTopConstrain:NO];
            [self setupRetweetPhotoViewHeight:0];
            [self retweetViewHiddenTopConstrain:NO];
        }
    }else {
        self.retweetContentView.text = @"";
        self.retweetPhotoImageView.photos = nil;
        [self retweetContentViewHiddenTopConstrain:YES];
        [self setupRetweetPhotoViewHeight:0];
        [self retweetViewHiddenTopConstrain:YES];
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

#pragma mark - 判断是否显示，更新约束
- (void)setupPhotoViewHeight:(NSUInteger)count
{
    if (count == 0) {
        @weakify(self);
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.statusLabel.mas_bottom);
            make.height.equalTo(@0);
        }];
    }else if (count <= 3) {
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(margin10);
            make.height.equalTo(@(MPStatusPhotoWH));
        }];
    }else if(count <= 6 && count > 3){
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(margin10);
            make.height.equalTo(@(MPStatusPhotoWH * 2 + margin10));
        }];
    }else {
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(margin10);
            make.height.equalTo(@(MPStatusPhotoWH * 3 + margin10 * 2));
        }];
    }
    [self updateConstraints];
}

- (void)setupRetweetPhotoViewHeight:(NSUInteger)count
{
    if (count == 0) {
        @weakify(self);
        [self.retweetPhotoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.retweetContentView.mas_bottom);
            make.height.equalTo(@0);
        }];
    }else if (count <= 3) {
        [self.retweetPhotoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.retweetContentView.mas_bottom).offset(margin10);
            make.height.equalTo(@(MPStatusPhotoWH));
        }];
    }else if(count <= 6 && count > 3){
        [self.retweetPhotoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.retweetContentView.mas_bottom).offset(margin10);
            make.height.equalTo(@(MPStatusPhotoWH * 2 + margin10));
        }];
    }else {
        [self.retweetPhotoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.retweetContentView.mas_bottom).offset(margin10);
            make.height.equalTo(@(MPStatusPhotoWH * 3 + margin10 * 2));
        }];
    }
    [super updateConstraints];
}

- (void)retweetViewHiddenTopConstrain:(BOOL)hidden
{
    if (hidden) {
        @weakify(self);
        [self.retweetView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.bottom.equalTo(self.retweetPhotoImageView);
        }];
    }else {
        @weakify(self);
        [self.retweetView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.bottom.equalTo(self.retweetPhotoImageView).offset(margin10);
        }];
    }
    [super updateConstraints];
}

- (void)retweetContentViewHiddenTopConstrain:(BOOL)hidden
{
    if (hidden) {
        @weakify(self);
        [self.retweetContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.retweetView);
        }];
    }else {
        @weakify(self);
        [self.retweetContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.retweetView).offset(margin10);
        }];
    }
    [super updateConstraints];
}

#pragma mark - 设置底部工具条
- (void)setupStatusToolBarWithStatus:(Status *)status
{
    [self setupBtnCount:[status.reposts_count intValue] btn:self.repostButton title:@"转发"];
    [self setupBtnCount:[status.comments_count intValue] btn:self.commentButton title:@"评论"];
    [self setupBtnCount:[status.attitudes_count intValue] btn:self.attitudeButton title:@"赞"];
}

- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

- (UIButton *)setupButtonsWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.toolBar addSubview:button];
    
    return button;
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
