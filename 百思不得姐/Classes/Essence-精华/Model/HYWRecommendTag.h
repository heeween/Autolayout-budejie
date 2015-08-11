//
//  HYWRecommendTag.h
//  百思不得姐
//
//  Created by heew on 14/5/24.
//  Copyright (c) 2014年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYWRecommendTag : NSObject

@property (nonatomic, assign) NSInteger is_sub; /**是否含有子标签 */
@property (nonatomic, strong) NSString *theme_id; /**此标签的id */
@property (nonatomic, strong) NSString *theme_name; /**标签名称 */
@property (nonatomic, strong) NSString *sub_number; /**此标签的订阅量 */
@property (nonatomic, assign) NSInteger is_default; /**是否是默认的推荐标签 */
@property (nonatomic, strong) NSString *image_list; /**推荐标签的图片url地址 */

@end
