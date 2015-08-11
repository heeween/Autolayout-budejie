//
//  HYWRecommendUserCell.m
//  百思不得姐
//
//  Created by heew on 15/7/23.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWRecommendUserCell.h"
#import "HYWRecommendUser.h"

@interface HYWRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *screen_name_label;
@property (weak, nonatomic) IBOutlet UILabel *fans_count_label;

@end
@implementation HYWRecommendUserCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    HYWRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setUser:(HYWRecommendUser *)user
{
    _user = user;
    [self.headerView setHeaderWithUrl:user.header];
    self.screen_name_label.text = user.screen_name;
    NSInteger fansCount = [user.fans_count integerValue];
    self.fans_count_label.text = fansCount > 10000 ? [NSString stringWithFormat:@"%.1f万人关注",fansCount /10000.0] : [NSString stringWithFormat:@"%zd人关注",fansCount];
}

@end
