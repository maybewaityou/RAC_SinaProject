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

@property (nonatomic, weak)UILabel *nameLabel;
@property (nonatomic, weak)UILabel *statusLabel;
@property (nonatomic, weak)UIImageView *userImageView;
//@property (nonatomic, weak)UIView *line;

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
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;

    UILabel *statusLabel = [[UILabel alloc] init];
    [self addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    UIImage *image = [UIImage imageNamed:@"avatar_default"];
    UIImageView *userImageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:userImageView];
    self.userImageView = userImageView;
    
//    UIView *line = [[UIView alloc] init];
//    [self addSubview:line];
//    self.line = line;
}

- (void)setupViews
{
    NSInteger margin10 = 10;
    NSInteger margin20 = 20;
    NSInteger defaultW = 44;
    NSInteger defaultH = 44;
    
    @weakify(self);
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(margin20);
        make.left.equalTo(self.userImageView.mas_right).offset(margin10);
        make.right.equalTo(self).offset(-margin10);
    }];
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.font = [UIFont systemFontOfSize:13.0];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.nameLabel).offset(margin10);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self).offset(-margin10);
        make.bottom.equalTo(self);
    }];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).offset(margin20);
        make.left.equalTo(self).offset(margin10);
        make.width.equalTo(@(defaultW));
        make.height.equalTo(@(defaultH));
    }];
//    self.line.backgroundColor = [UIColor grayColor];
//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self);
//        make.left.equalTo(self).offset(margin10);
//        make.right.equalTo(self);
//        make.height.equalTo(@(1));
//    }];
}

- (void)bindViewModel:(id)viewModel
{
    Status *status = (Status *)viewModel;
    self.nameLabel.text = status.user.name;
    self.statusLabel.text = status.text;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url]];
}

#if 1

// If you are not using auto layout, override this method
- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.nameLabel sizeThatFits:size].height;
    totalHeight += [self.statusLabel sizeThatFits:size].height;
    totalHeight += [self.userImageView sizeThatFits:size].height;
    totalHeight += 0; // margins
    return CGSizeMake(size.width, totalHeight);
}

#endif

@end
