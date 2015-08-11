//
//  HYWTopicCell.h
//  百思不得姐
//
//  Created by heew on 15/7/27.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HYWTopic;
@interface HYWTopicCell : UITableViewCell
@property (nonatomic, strong) HYWTopic *topic; /**帖子模型 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end




@interface HYWContentButton : UIButton // 顶\踩\分享\评论按钮
- (void)setTitleCount:(NSInteger)count placeholder:(NSString *)placeholder;
@end




@interface HYWTopicCellBgView : UIView // 立体感背景
@end