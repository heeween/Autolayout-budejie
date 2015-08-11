//
//  XMGTopicPictureView.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/29.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class HYWTopic;

@interface HYWTopicPictureView : UIView
+ (instancetype)pictureView;


@property (nonatomic, strong) HYWTopic *topic; // 帖子模型
@end
