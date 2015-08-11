//
//  HYWRecommentCategeryCell.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWRecommendCategoryCell.h"
#import "HYWRecommendCategory.h"


@interface HYWRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end
@implementation HYWRecommendCategoryCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    HYWRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"category"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}


- (void)setRecommendCategory:(HYWRecommendCategory *)recommendCategory
{
    _recommendCategory = recommendCategory;
    self.categoryLabel.text = recommendCategory.name;
}

- (void)awakeFromNib {
    self.backgroundColor = HYWColr(244, 244, 244);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.redView.hidden = !selected;
    self.categoryLabel.textColor = selected ? HYWColr(219, 21, 26) :HYWColr(78, 78, 78);
}


@end
