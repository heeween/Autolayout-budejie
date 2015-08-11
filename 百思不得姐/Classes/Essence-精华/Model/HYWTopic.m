//
//  HYWTopic.m
//  百思不得姐
//
//  Created by heew on 15/7/27.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWTopic.h"

@implementation HYWTopic

- (void)setCreate_time:(NSString *)create_time {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *createDate = [fmt dateFromString:create_time];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([createDate isThisYear]) { // 今年
        if ([calendar isDateInToday:createDate]) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:createDate];
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                _create_time = [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                _create_time = [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                _create_time = @"刚刚";
            }
        }else if ([calendar isDateInYesterday:createDate]){ // 昨天
            fmt.dateFormat = @"昨天: HH:mm:ss";
            _create_time = [fmt stringFromDate:createDate];
        }else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            _create_time = [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        _create_time = create_time;
    }
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}
//+ (NSDictionary *)objectClassInArray
//{
//    //    return @{@"top_cmt" : [XMGComment class]};
//    return @{@"top_cmt" : @"XMGComment"};
//}
- (CGSize)pictureSize {
    if (self.type == HYWTopicTextType) {
        return CGSizeZero;
    }
    // 显示显示出来的高度
    CGFloat pictureW = HYWScreenW - 2 * HYWTopicCellMargin;
    CGFloat pictureH = pictureW * self.height / self.width;
    if (pictureH >= 800) { // 图片高度过长
        pictureH = 250;
        self.bigPicture = YES; // 大图
    }
    return CGSizeMake(pictureW, pictureH);
}
@end
