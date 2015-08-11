//
//  HYWCommentController.h
//  百思不得姐
//
//  Created by heew on 15/8/2.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYWTopic;
@interface HYWCommentController : UIViewController
@property (nonatomic, strong) NSString *ID; /**当前帖子的ID */
@property (nonatomic, strong) HYWTopic *topic; /**当前帖子的模型 */
@end
