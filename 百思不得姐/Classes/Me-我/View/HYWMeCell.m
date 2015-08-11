//
//  HYWMeCell.m
//  百思不得姐
//
//  Created by heew on 15/8/4.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWMeCell.h"

@implementation HYWMeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *square = @"square";
    HYWMeCell *cell = [tableView dequeueReusableCellWithIdentifier:square];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:square];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.viewWidth = 30;
    self.imageView.viewHeight = self.imageView.viewWidth;
    self.imageView.viewCenterY = self.contentView.viewHeight * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + HYWTopicCellMargin;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
