//
//  HYWRecommendTag.m
//  百思不得姐
//
//  Created by heew on 14/5/24.
//  Copyright (c) 2014年 adhx. All rights reserved.
//

#import "HYWRecommendTag.h"

@implementation HYWRecommendTag
- (void)setSub_number:(NSString *)sub_number {
    
    NSInteger sub_number_ = [sub_number integerValue];
    _sub_number = sub_number_ > 10000 ? [NSString stringWithFormat:@"%.1f万人订阅",sub_number_ /10000.0] : [NSString stringWithFormat:@"%zd人订阅",sub_number_];
}
@end
