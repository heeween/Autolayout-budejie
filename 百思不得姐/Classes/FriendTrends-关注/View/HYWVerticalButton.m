//
//  HYWSettingButton.m
//  网易新闻首页
//
//  Created by heew on 15/7/7.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWVerticalButton.h"

static const NSInteger kImageTitleMargin = 10;

@implementation HYWVerticalButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect imageF = self.imageView.frame;
    CGRect titleF = self.titleLabel.frame;
    
    // 设置图片位置
    imageF.origin.x = (self.frame.size.width / 2) - (imageF.size.width / 2);
    imageF.origin.y = (self.frame.size.height / 2) - (imageF.size.height / 2) - (titleF.size.height / 2) - kImageTitleMargin;
    self.imageView.frame = imageF;
    
    // 设置标题位置
    titleF.origin.y = CGRectGetMaxY(imageF) + kImageTitleMargin;
    titleF.size.width = self.frame.size.width;
    self.titleLabel.frame = titleF;
    CGPoint titleCenter = self.titleLabel.center;
    titleCenter.x = self.imageView.center.x;
    self.titleLabel.center = titleCenter;
}
@end
