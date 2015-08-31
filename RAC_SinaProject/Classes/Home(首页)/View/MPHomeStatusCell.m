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

@interface MPHomeStatusCell ()

@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UILabel *statusLabel;
@property (nonatomic, weak)UIImageView *userImageView;

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
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;

    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.numberOfLines = 0;
    statusLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UIImage *image = [UIImage imageNamed:@"avatar_default"];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:image];
    [self.contentView addSubview:userImageView];
    self.userImageView = userImageView;
    
}

- (void)setupViews
{
    NSInteger margin5 = 5;
    NSInteger margin10 = 10;
    NSInteger defaultW = 44;
    NSInteger defaultH = 44;
    
    @weakify(self);
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView).offset(margin10);
        make.left.equalTo(self.contentView).offset(margin10);
        make.width.equalTo(@(defaultW));
        make.height.equalTo(@(defaultH));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView);
        make.left.equalTo(self.userImageView.mas_right).offset(margin10);
        make.right.equalTo(self.contentView).offset(-margin10);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(margin5);
        make.left.equalTo(self.userImageView.mas_right).offset(margin10);
        make.right.equalTo(self.nameLabel);
    }];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.userImageView).offset(-margin10);
        make.left.equalTo(self.userImageView).offset(-margin10);
        make.bottom.equalTo(self.statusLabel).offset(margin10);
        make.width.equalTo(self.mas_width);
    }];
}

- (void)bindViewModel:(id)viewModel
{
    Status *status = (Status *)viewModel;
    self.viewModel.status = status;
    self.nameLabel.text = self.viewModel.status.user.name;
    self.statusLabel.text = self.viewModel.status.text;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.status.user.profile_image_url]];
    
//    [[RACObserve(self.viewModel, status) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(Status *status) {
//        NSLog(@"===>>> %@",status.user.name);
//    }];
    
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
