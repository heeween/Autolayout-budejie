//
//  HYWRecommentUserDelegate.h
//  百思不得姐
//
//  Created by heew on 15/7/23.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYWRecommendCategory;
@interface HYWRecommendUserDelegate : NSObject <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) HYWRecommendCategory *recommentdCategory; /**记录对应左侧关注列表模型 */
@end
