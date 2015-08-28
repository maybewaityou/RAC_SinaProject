//
//  TestViewController01.m
//  RAC_SinaProject
//
//  Created by ChunNan on 15/8/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "TestViewController01.h"
#import "TestViewController02.h"
#import "UIColor+Extension.h"


@interface TestViewController01 ()

@end

@implementation TestViewController01

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    TestViewController02 *controller = [[TestViewController02 alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)dealloc
{
    NSLog(@"===>>> %@ dealloc",self);
}

@end
