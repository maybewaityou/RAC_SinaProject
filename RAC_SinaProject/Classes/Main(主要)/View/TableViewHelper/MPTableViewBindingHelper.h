//
//  MPTableViewBindingHelper.h
//  JCookDemo
//
//  Created by ChunNan on 15/6/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;
@class RACCommand;

@interface MPTableViewBindingHelper : NSObject

+ (instancetype) bindingHelpWithTableView:(UITableView *)tableView
                             sourceSignal:(RACSignal *)source
                         selectionCommand:(RACCommand *)selection
                        templateCellClass:(Class)cellClass;


@end
