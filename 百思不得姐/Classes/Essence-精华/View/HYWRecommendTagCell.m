//
//  HYWRecommendTageCell.m
//  百思不得姐
//
//  Created by heew on 15/7/24.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWRecommendTagCell.h"
#import "HYWRecommendTag.h"



@interface HYWRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_list;
@property (weak, nonatomic) IBOutlet UILabel *theme_name_label;
@property (weak, nonatomic) IBOutlet UILabel *sub_number_label;

@end

@implementation HYWRecommendTagCell

- (void)setRecommendTag:(HYWRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.image_list setHeaderWithUrl:recommendTag.image_list];
    self.theme_name_label.text = recommendTag.theme_name;
    self.sub_number_label.text = recommendTag.sub_number;

}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    HYWRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendTag"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 2;
    [super setFrame:frame];
}
@end
