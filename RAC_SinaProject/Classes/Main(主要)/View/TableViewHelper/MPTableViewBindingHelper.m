//
//  MPTableViewBindingHelper.m
//  JCookDemo
//
//  Created by ChunNan on 15/6/27.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "MPTableViewBindingHelper.h"
#import "MPReactiveView.h"

@interface MPTableViewBindingHelper () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_data;
    UITableViewCell *_templateCell;
    RACCommand *_selection;
}

@end

@implementation MPTableViewBindingHelper

- (instancetype) initWithTableView:(UITableView *)tableView
                      sourceSignal:(RACSignal *)source
                  selectionCommand:(RACCommand *)selection
                 templateCellClass:(Class)cellClass
{
    if (self = [super init]) {
        _tableView = tableView;
        _selection = selection;
        _data = [NSArray array];
        
        // each time the view model updates the array property, store the latest
        // value and reload the table view
        [source subscribeNext:^(id x) {
            _data = x;
            [_tableView reloadData];
        }];
        
        // create an instance of the template cell and register
        // with the table view
        [_tableView registerClass:cellClass forCellReuseIdentifier:@"cell"];
        
        // use the template cell to set the row height
        //        _tableView.rowHeight = _templateCell.bounds.size.height;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

+ (instancetype)bindingHelpWithTableView:(UITableView *)tableView
                            sourceSignal:(RACSignal *)source
                        selectionCommand:(RACCommand *)selection
                       templateCellClass:(Class)cellClass
{
    return [[self alloc] initWithTableView:tableView sourceSignal:source selectionCommand:selection templateCellClass:cellClass];
}

#pragma mark - UITableViewDataSource implementation

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<MPReactiveView> cell = [tableView
                               dequeueReusableCellWithIdentifier:@"cell"];
    [cell bindViewModel:_data[indexPath.row]];
    return (UITableViewCell *)cell;
}

#pragma mark - UITableViewDelegate implementation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_selection execute:_data[indexPath.row]];
}

@end
