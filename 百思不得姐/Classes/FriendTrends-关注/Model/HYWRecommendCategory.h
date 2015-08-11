//
//  HYWCategery.h
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYWRecommendCategory : NSObject
@property (nonatomic, strong) NSString *ID; /**标签 */
@property (nonatomic, strong) NSString *name; /**标题 */
@property (nonatomic, assign) NSInteger count; /**子分类数量 */
@property (nonatomic, assign) NSInteger total; /**一共加载来的多少个推荐用户 */
@property (nonatomic, assign,getter = isSelected) BOOL *selected; /**记录cell是否被选中 */
@property (nonatomic, strong) NSMutableArray *users; /**右侧关注详情模型数组 */
@property (nonatomic, assign) NSInteger currentPage; /**记录当前加载的页数 */
@end
