//
//  HYWComment.h
//  百思不得姐
//
//  Created by heew on 15/8/2.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYWUser;
@interface HYWComment : NSObject

@property (nonatomic, copy) NSString *ID; /** id */
@property (nonatomic, assign) NSInteger voicetime; /** 音频文件的时长 */
@property (nonatomic, copy) NSString *voiceuri; /** 音频文件的路径 */
@property (nonatomic, copy) NSString *content; /** 评论的文字内容 */
@property (nonatomic, assign) NSInteger like_count; /** 被点赞的数量 */
@property (nonatomic, strong) HYWUser *user; /**用户字典 */
@end
