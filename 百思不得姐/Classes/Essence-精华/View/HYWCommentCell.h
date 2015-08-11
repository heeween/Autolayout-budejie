//
//  HYWCommentCell.h
//  百思不得姐
//
//  Created by heew on 15/8/3.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString * const comment = @"comment";
@class HYWComment;
@interface HYWCommentCell : UITableViewCell
@property (nonatomic, strong) HYWComment *comment; /**评论模型 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
