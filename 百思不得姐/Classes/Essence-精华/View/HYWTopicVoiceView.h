//
//  HYWTopicVoiceView.h
//  百思不得姐
//
//  Created by heew on 15/7/31.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYWTopic;


@interface HYWTopicVoiceView : UIView

+ (instancetype)voiceView;


@property (nonatomic, strong) HYWTopic *topic; // 帖子模型
@end
