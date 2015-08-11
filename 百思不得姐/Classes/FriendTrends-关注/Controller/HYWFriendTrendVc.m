//
//  HYWFriendTrendVc.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWFriendTrendVc.h"
#import "HYWRecommentVc.h"
#import "HYWRecommendCategory.h"
#import "HYWLoginRegistController.h"



@interface HYWLoginRegistController ()

@end
@implementation HYWFriendTrendVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = HYWColr(223, 223, 223);
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithbg:@"friendsRecommentIcon" bgHighlighted:@"friendsRecommentIcon-click" target:self action:@selector(recommentClick)];
    
}
- (IBAction)loginRegistButton:(id)sender {
    HYWLoginRegistController *loginRegistVc = [[HYWLoginRegistController alloc] init];
    [self presentViewController:loginRegistVc animated:YES completion:nil];
}

- (void)recommentClick
{
    HYWRecommentVc *vc = [[HYWRecommentVc alloc] init];
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
