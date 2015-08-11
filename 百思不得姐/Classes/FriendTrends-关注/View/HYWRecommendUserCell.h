//
//  HYWRecommendUserCell.h
//  百思不得姐
//
//  Created by heew on 15/7/23.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYWRecommendUser;
@interface HYWRecommendUserCell : UITableViewCell
@property (nonatomic, strong) HYWRecommendUser *user; /**用户模型 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
