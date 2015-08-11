//
//  HYWCommnetHeaderFooter.h
//  百思不得姐
//
//  Created by heew on 15/8/3.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const commentHeaderFooter = @"commentHeaderFooter";

@interface HYWCommnetHeaderFooter : UITableViewHeaderFooterView
+ (instancetype)HeaderFooterViewWithTableView:(UITableView *)tableview;
@property (nonatomic, strong) NSString *title; /**每组的标题 */
@end
