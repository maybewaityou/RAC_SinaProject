//
//  MPReactiveView.h
//  JCookDemo
//
//  Created by ChunNan on 15/6/22.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import <Foundation/Foundation.h>

/// A protocol which is adopted by views which are backed by view models.
@protocol MPReactiveView <NSObject>

/// Binds the given view model to the view
- (void)bindViewModel:(id)viewModel;

@end
