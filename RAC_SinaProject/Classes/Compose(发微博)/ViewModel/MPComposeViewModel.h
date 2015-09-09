//
//  MPComposeViewModel.h
//  RAC_SinaProject
//
//  Created by ChunNan on 15/9/9.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVMViewModel.h"

@interface MPComposeViewModel : RVMViewModel

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSMutableAttributedString *attrStr;

@property (nonatomic, copy)NSString *textToSend;

@property (nonatomic, assign)BOOL isSendSuccess;

- (instancetype)initWithNavController:(UINavigationController *)controller;

- (void)sendStatus;

@end
