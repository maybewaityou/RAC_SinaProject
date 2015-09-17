//
//  MPEmotionPageView.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/17.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define MPEmotionMaxRows 3
// 一行中最多7列
#define MPEmotionMaxCols 7
// 每一页的表情个数
#define MPEmotionPageSize ((MPEmotionMaxRows * MPEmotionMaxCols) - 1)

@interface MPEmotionPageView : UIView

@property (nonatomic, copy) NSArray *emotions;

@end
