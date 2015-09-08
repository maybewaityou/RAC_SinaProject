//
//  MPUserIconView.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPUserIconView.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "RACEXTScope.h"

@interface MPUserIconView ()

@property (nonatomic, weak)UIImageView *verifiedView;

@end

@implementation MPUserIconView

- (void)setUser:(User *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];

    switch (user.verified_type) {
        case MPUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case MPUserVerifiedOrgEnterprice:
        case MPUserVerifiedOrgMedia:
        case MPUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case MPUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
    }
}

- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
        [verifiedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(8);
            make.bottom.equalTo(self).offset(8);
        }];
    }
    return _verifiedView;
}

@end
