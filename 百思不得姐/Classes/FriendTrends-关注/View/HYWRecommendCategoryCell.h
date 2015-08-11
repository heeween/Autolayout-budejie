//
//  HYWRecommentCategeryCell.h
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYWRecommendCategory;
@interface HYWRecommendCategoryCell : UITableViewCell
/**模型 */
@property (nonatomic, strong) HYWRecommendCategory *recommendCategory;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
