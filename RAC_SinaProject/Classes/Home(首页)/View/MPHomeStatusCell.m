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
#import "UIColor+Extension.h"

#define margin5 (5)
#define margin10 (10)
#define defaultW (50)
#define defaultH (50)
#define photoViewW (100)
#define photoViewH (100)

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

/**
 *  转发微博
 */
@property (nonatomic, weak)UIView *retweetView;
@property (nonatomic, weak)UILabel *retweetContentView;
@property (nonatomic, weak)UIImageView *retweetPhotoImageView;

/**
 *  转发、评论、赞
 */
@property (nonatomic, weak)UIView *toolBar;
@property (nonatomic, weak)UIButton *repostButton;
@property (nonatomic, weak)UIButton *commentButton;
@property (nonatomic, weak)UIButton *attitudeButton;

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

- (void)initOriginalStatusViews
{
    // 原创微博
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
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

- (void)initRepostStatusViews
{
    // 转发微博
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentView = [[UILabel alloc] init];
    retweetContentView.font = [UIFont systemFontOfSize:13.0];
    retweetContentView.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentView];
    self.retweetContentView = retweetContentView;
    
    UIImageView *retweetPhotoImageView = [[UIImageView alloc] init];
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
}

- (void)setupOriginalStatusViews
{
    // 原创微博
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
        make.width.equalTo(@photoViewW);
        make.height.equalTo(@photoViewH);
    }];
    [self.originalView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView).offset(-margin10);
        make.left.equalTo(self.userImageView).offset(-margin10);
        make.bottom.equalTo(self.photoImageView).offset(margin10);
        make.width.equalTo(self.mas_width);
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
        make.top.equalTo(self.retweetContentView.mas_bottom).offset(margin5);
        make.left.equalTo(self.retweetContentView);
        make.width.equalTo(@photoViewW);
        make.height.equalTo(@photoViewH);
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
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.repostButton);
        make.left.equalTo(self.repostButton.mas_right);
        make.width.equalTo(@(toolBarDefaultW));
        make.height.equalTo(@(toolBarDefaultH));
    }];
    [self.attitudeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.repostButton);
        make.left.equalTo(self.commentButton.mas_right);
        make.width.equalTo(@(toolBarDefaultW));
        make.height.equalTo(@(toolBarDefaultH));
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
        [self photoImageHidden:NO];
    }else {
        [self photoImageHidden:YES];
    }
    
    if (status.retweeted_status) {
        Status *retweetStatus = status.retweeted_status;
        User *retweetStatusUser = retweetStatus.user;
        /** 被转发的微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweetStatusUser.name, retweetStatus.text];
        self.retweetContentView.text = retweetContent;

        if (retweetStatus.pic_urls.count) {
            [self.retweetPhotoImageView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.pic_urls[0][@"thumbnail_pic"]]];
            [self retweetContentViewHiddenTopConstrain:NO];
            [self retweetViewHiddenTopConstrain:NO];
            [self retweetPhotoViewHidden:NO];
        }else{
            [self retweetContentViewHiddenTopConstrain:NO];
            [self retweetViewHiddenTopConstrain:NO];
            [self retweetPhotoViewHidden:YES];
        }
    }else {
        self.retweetContentView.text = @"";
        [self retweetContentViewHiddenTopConstrain:YES];
        [self retweetViewHiddenTopConstrain:YES];
        [self retweetPhotoViewHidden:YES];
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

- (void)photoImageHidden:(BOOL)hidden
{
    if (hidden) {
        @weakify(self);
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.statusLabel.mas_bottom);
            make.height.equalTo(@0);
        }];
    }else{
        [self.photoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusLabel.mas_bottom).offset(margin5);
            make.height.equalTo(@photoViewH);
        }];
    }
    [super updateConstraints];
}

- (void)retweetPhotoViewHidden:(BOOL)hidden
{
    if (hidden) {
        @weakify(self);
        [self.retweetPhotoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.retweetContentView.mas_bottom);
            make.height.equalTo(@0);
        }];
    }else{
        @weakify(self);
        [self.retweetPhotoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.retweetContentView.mas_bottom).offset(margin5);
            make.height.equalTo(@photoViewH);
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
