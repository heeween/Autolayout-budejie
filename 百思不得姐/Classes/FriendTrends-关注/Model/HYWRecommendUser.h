//
//  HYWRecommentUser.h
//  百思不得姐
//
//  Created by heew on 15/7/23.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYWRecommendUser : NSObject
@property (nonatomic, strong) NSString *uid; /**推荐的用户id */
@property (nonatomic, strong) NSString *fans_count; /**所推荐用户的被关注量 */
@property (nonatomic, assign) NSInteger is_follow; /**是否是我关注的用户 */
@property (nonatomic, assign) NSInteger gender; /**性别 */
@property (nonatomic, strong) NSString *screen_name; /**所推荐的用户昵称 */
@property (nonatomic, strong) NSString *header; /**所推荐的用户的头像url */
@property (nonatomic, strong) NSString *introduction; /**用户描述 */
@property (nonatomic, assign) NSInteger *tize_count; /**所发表的帖子数量 */
@end
