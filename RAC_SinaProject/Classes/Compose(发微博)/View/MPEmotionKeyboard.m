//
//  MPEmotionKeyboard.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/13.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPEmotionKeyboard.h"
#import "MPEmotionListView.h"
#import "MPEmotionTabBar.h"
#import "UIView+Extension.h"

@interface MPEmotionKeyboard ()

@property (nonatomic, weak)MPEmotionListView *listView;
@property (nonatomic, weak)MPEmotionTabBar *tabBar;

@end


@implementation MPEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    MPEmotionListView *listView = [[MPEmotionListView alloc] init];
    listView.backgroundColor = [UIColor redColor];
    [self addSubview:listView];
    self.listView = listView;
    
    MPEmotionTabBar *tabBar = [[MPEmotionTabBar alloc] init];
    tabBar.backgroundColor = [UIColor blueColor];
    [self addSubview:tabBar];
    self.tabBar = tabBar;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.height;
    
    self.tabBar.height = 44;
    self.tabBar.width = self.width;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
}

@end
