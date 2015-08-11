//
//  HYWRecommendTageCell.h
//  百思不得姐
//
//  Created by heew on 15/7/24.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYWRecommendTag;
@interface HYWRecommendTagCell : UITableViewCell
@property (nonatomic, strong) HYWRecommendTag *recommendTag; /**关注标签模型 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
