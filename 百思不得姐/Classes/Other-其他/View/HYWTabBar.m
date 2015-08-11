//
//  HYWTabBar.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWTabBar.h"

@interface HYWTabBar ()
@end

@implementation HYWTabBar

- (void)layoutSubviews {
    static BOOL add = NO;
    [super layoutSubviews];
    NSInteger index = 0;
    for (UIControl *control in self.subviews) {
        if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGFloat controlW = self.viewWidth / 5.0;
            CGFloat controlH = self.viewHeight;
            CGFloat controlY = 0;
            CGFloat controlX = controlW * (index > 1 ? (index + 1) : index);
            control.frame = CGRectMake(controlX, controlY, controlW, controlH);
            index++;
            if (add == NO) {
                [control addTarget:self action:@selector(tabBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    add = YES;
}

- (void)tabBarButtonClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:HYWTabBarButtonClick object:nil];
}


@end
