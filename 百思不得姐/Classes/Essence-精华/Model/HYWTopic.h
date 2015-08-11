//
//  HYWTopic.h
//  百思不得姐
//
//  Created by heew on 14/5/27.
//  Copyright (c) 2014年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYWComment;
@interface HYWTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name; /**名称 */
@property (nonatomic, copy) NSString *create_time; /**发帖时间 */
@property (nonatomic, copy) NSString *profile_image; /**头像 */
@property (nonatomic, copy) NSString *text; /**正文 */
@property (nonatomic, assign) NSInteger ding; /**顶得数量 */
@property (nonatomic, assign) NSInteger cai; /**踩的数量 */
@property (nonatomic, assign) NSInteger repost; /**转发数量 */
@property (nonatomic, assign) NSInteger comment; /**评论的数量 */
@property (nonatomic, assign, getter = isSina_v) BOOL sina_v; /** 是否为新浪加V用户 */
@property (nonatomic, copy) NSString *small_image; /** 小图片的URL */
@property (nonatomic, copy) NSString *middle_image; /** 中图片的URL */
@property (nonatomic, copy) NSString *large_image; /** 大图片的URL */
@property (nonatomic, assign) HYWTopicType type; /**帖子类型 */
@property (nonatomic, assign) CGFloat width; /** 图片的宽度 */
@property (nonatomic, assign) CGFloat height; /** 图片的高度 */
@property (nonatomic, assign) NSInteger voicetime; /** 音频时长 */
@property (nonatomic, assign) NSInteger videotime; /** 视频时长 */
@property (nonatomic, assign) NSInteger playcount; /** 播放次数 */
@property (nonatomic, strong) HYWComment *top_cmt; /**评论模型 */

/****** 额外的辅助属性 ******/

@property (nonatomic, assign,readonly) CGSize pictureSize; /**图片显示大小 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture; /** 图片是否太大 */
@property (nonatomic, assign) CGFloat pictureProgress; /** 图片的下载进度 */

@end
