//
//  HYWLogin&registController.m
//  百思不得姐
//
//  Created by heew on 15/7/26.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWLoginRegistController.h"

@interface HYWLoginRegistController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginRegistConstrain;

@end

@implementation HYWLoginRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginRegistSwitch:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.loginRegistConstrain.constant = sender.selected ? -self.view.frame.size.width : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
