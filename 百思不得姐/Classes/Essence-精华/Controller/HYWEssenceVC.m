//
//  HYWEssenceVC.m
//  百思不得姐
//
//  Created by heew on 14/7/22.
//  Copyright (c) 2014年 adhx. All rights reserved.
//

#import "HYWEssenceVC.h"
#import "HYWRecommendTagController.h"
#import "HYWRecommendTag.h"
#import "HYWTopicController.h"





@interface HYWEssenceVC ()
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (nonatomic, strong) UIViewController *lastVc; /**记录上一次的控制器 */
@property (weak, nonatomic) IBOutlet UIView *redView;
@end



@implementation HYWEssenceVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HYWColr(223, 223, 223);
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithbg:@"MainTagSubIcon" bgHighlighted:@"MainTagSubIconClick" target:self action:@selector(recommendTag)];
    
    [self setupChildViewController];
    
}

- (void)setupChildViewController {
    
    HYWTopicController *pictureVc = [[HYWTopicController alloc] init];
    pictureVc.type = HYWTopicPictureType;
    self.lastVc = pictureVc;
    [self addChildViewController:pictureVc];
    
    HYWTopicController *videoVc = [[HYWTopicController alloc] init];
    videoVc.type = HYWTopicVideoType;
    [self addChildViewController:videoVc];
    
    HYWTopicController *voiceVc = [[HYWTopicController alloc] init];
    voiceVc.type = HYWTopicVoiceType;
    [self addChildViewController:voiceVc];
    
    HYWTopicController *allVc = [[HYWTopicController alloc] init];
    allVc.type = HYWTopicAllType;
    [self addChildViewController:allVc];
    
    HYWTopicController *textVc = [[HYWTopicController alloc] init];
    textVc.type = HYWTopicTextType;
    [self addChildViewController:textVc];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view insertSubview:[self.childViewControllers[0] view] atIndex:0];
}

- (IBAction)titleButtonClick:(UIButton *)button {
    UIViewController *currentVc = self.childViewControllers[button.tag];
    if (currentVc == self.lastVc) return;
    [self transitionFromViewController:self.lastVc toViewController:currentVc duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve  animations:^{
        self.redView.transform = CGAffineTransformMakeTranslation(button.tag * self.redView.viewWidth, 0);
    } completion:^(BOOL finished) {
        self.lastVc = currentVc;
    }];
    [self.view bringSubviewToFront:self.titleView];
} // 子控制器切换

- (void)recommendTag {
    HYWRecommendTagController *recommendTagVc = [[HYWRecommendTagController alloc] init];
    [self.navigationController pushViewController:recommendTagVc animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [SVProgressHUD showWithStatus:@"正在努力加载" maskType:SVProgressHUDMaskTypeGradient];
    [[AFHTTPSessionManager manager] GET:kBaseUrl parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        recommendTagVc.recommendTags = [HYWRecommendTag objectArrayWithKeyValuesArray:responseObject];
        [recommendTagVc.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
} // 推荐关注点击方法

@end
