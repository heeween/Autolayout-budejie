//
//  HYWRecommentUserDelegate.m
//  百思不得姐
//
//  Created by heew on 15/7/23.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWRecommendUserDelegate.h"
#import "HYWRecommendUserCell.h"
#import "HYWRecommendCategory.h"

@implementation HYWRecommendUserDelegate

#pragma mark - datasource

// 每一组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommentdCategory.users.count;
}

// 每一个行的细节
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYWRecommendUserCell *cell = [HYWRecommendUserCell cellWithTableView:tableView];
    cell.user = self.recommentdCategory.users[indexPath.row];
    return cell;
}

@end
