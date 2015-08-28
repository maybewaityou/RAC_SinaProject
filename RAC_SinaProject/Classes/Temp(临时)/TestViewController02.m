//
//  TestViewController02.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "TestViewController02.h"
#import "TestViewController03.h"

@interface TestViewController02 ()

@end

@implementation TestViewController02

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    TestViewController03 *controller = [[TestViewController03 alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
