
//
//  HYWGuideView.m
//  百思不得姐
//
//  Created by heew on 15/7/27.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWGuideView.h"

@implementation HYWGuideView

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show {
    NSString *cacheVersion = [[NSUserDefaults standardUserDefaults] objectForKey:Versionkey];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[Versionkey];
    if ([currentVersion isEqualToString:cacheVersion]) {
        return;
    }else {
        HYWGuideView *guiderView = [self guideView];
        guiderView.frame = HYWScreenBounds;
        [HYWKeyWindow addSubview:guiderView];
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:Versionkey];
    }
}
- (IBAction)hide {
    [self removeFromSuperview];
}
@end
