//
//  HYWPublishController.m
//  百思不得姐
//
//  Created by heew on 13/3/30.
//  Copyright (c) 2013年 adhx. All rights reserved.
//

#import "HYWPublishController.h"
#import <POP.h>

@interface HYWPublishController ()
@property (weak, nonatomic) IBOutlet UIView *buttonContainer;
@property (weak, nonatomic) IBOutlet UIImageView *sloganView;
@property (nonatomic, strong) UIDynamicAnimator *animator;/** 物理仿真器 */
@end



@implementation HYWPublishController
- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        // 创建物理仿真器(ReferenceView, 参照视图, 其实就是设置仿真范围)
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showsloganView];
}
/**
 *  显示标语view
 */
- (void)showsloganView {
    CGPoint sloganCenter = self.sloganView.center;
    CGFloat snapMargin = -35.0;
    CGPoint snapPoint = CGPointMake(HYWScreenW * 0.5, sloganCenter.y - snapMargin);
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.sloganView snapToPoint:snapPoint];
    snap.damping = 0.1;
    [self.animator addBehavior:snap];
}
/**
 *  显示按钮
 *
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showButton];
}

static CGFloat const HYWSpringFactor = 0.1;

/**
 *  按钮动画设置
 */
- (void)showButton {
    
    for (int i = 0; i < self.buttonContainer.subviews.count; i++) {
        UIButton *button = self.buttonContainer.subviews[i];
        
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerOpacity
                              fromValue:@(0)
                                toValue:@(1.0)
                       springBounciness:0.1
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + HYWSpringFactor *i];
        
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerScaleXY
                              fromValue:[NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)]
                                toValue:[NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)]
                       springBounciness:18
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + HYWSpringFactor *i];

        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerPositionY
                              fromValue:@(0)
                                toValue:@(button.layer.position.y)
                       springBounciness:12
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + HYWSpringFactor * i];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


/**
 *  结束动画
 */

- (void)dismissWithCompletionBlock:(void(^)(void))completionBlock {
    for (int i = 0; i < self.buttonContainer.subviews.count; i++) {
        UIButton *button = self.buttonContainer.subviews[i];
        
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerOpacity
                              fromValue:@(1)
                                toValue:@(0)
                       springBounciness:0.1
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + HYWSpringFactor * (self.buttonContainer.subviews.count - 1 - i)];
        
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerScaleXY
                              fromValue:[NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)]
                                toValue:[NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)]
                       springBounciness:18
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + HYWSpringFactor * (self.buttonContainer.subviews.count - 1 - i)];
        
        
        POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        layerPositionAnimation.fromValue = @(button.layer.position.y);
        layerPositionAnimation.toValue = @(HYWScreenH);
        layerPositionAnimation.springBounciness = 12;
        layerPositionAnimation.springSpeed = 1;
        layerPositionAnimation.beginTime = CACurrentMediaTime() + HYWSpringFactor * (self.buttonContainer.subviews.count - 1 - i);
        [button.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
        
        if (i == self.buttonContainer.subviews.count - 1) {
            [layerPositionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:YES completion:nil];
                if (completionBlock) {
                    completionBlock();
                }
            }];
        }
    }
    
}


- (void)buttonClick:(UIButton *)button {
    if (button.tag == 2) {
        nil;
    }
}

/**
 *  创建动画方法
 */

- (void)setupButtonLayerAnimation:(CALayer *)layer
            propertyAnimationName:(NSString *)name
                        fromValue:(id) fromValue
                          toValue:(id) toValue
                 springBounciness:(CGFloat)springBounciness
                      springSpeed:(CGFloat)springSpeed
                       begingTime:(CFTimeInterval)beginTime {
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:name];
    layerPositionAnimation.fromValue = fromValue;
    layerPositionAnimation.toValue = toValue;
    layerPositionAnimation.springBounciness = springBounciness;
    layerPositionAnimation.springSpeed = springSpeed;
    layerPositionAnimation.beginTime = beginTime;
    [layer pop_addAnimation:layerPositionAnimation forKey:nil];
}

/**
 *  取消按钮点击方法
 */
- (IBAction)cancelButtonClick:(id)sender {
    [self dismissWithCompletionBlock:nil];
}


/**
 *  取消按钮点击方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissWithCompletionBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
