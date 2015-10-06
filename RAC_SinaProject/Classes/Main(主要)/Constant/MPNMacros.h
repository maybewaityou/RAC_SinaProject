//
//  MPNMacros.h
//  JCookDemo
//
//  Created by ChunNan on 15/6/3.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XCODE_COLORS_ESCAPE @"\033["

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define MPStatusPhotoWH ((SCREEN_WIDTH - 40) / 3.0)
#define margin5 (5)
#define margin10 (10)
#define defaultW (44)
#define defaultH (44)

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define MPQueryNewStatusSQL [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;",params[@"since_id"]]
#define MPQueryMoreStatUsSQL [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;",params[@"max_id"]]