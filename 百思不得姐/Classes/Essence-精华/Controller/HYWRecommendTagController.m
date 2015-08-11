//
//  HYWRecommendTagController.m
//  百思不得姐
//
//  Created by heew on 14/7/24.
//  Copyright (c) 2014年 adhx. All rights reserved.
//

#import "HYWRecommendTagController.h"
#import "HYWRecommendTagCell.h"
#import "HYWRecommendTag.h"


@interface HYWRecommendTagController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HYWRecommendTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HYWColr(223, 223, 223);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HYWRecommendTagCell *cell = [HYWRecommendTagCell cellWithTableView:tableView];
    HYWRecommendTag *recommendTag = self.recommendTags[indexPath.row];
    cell.recommendTag = recommendTag;
    return cell;
}


@end
