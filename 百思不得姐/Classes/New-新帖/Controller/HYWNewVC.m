//
//  HYWNewVC.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWNewVC.h"

@implementation HYWNewVC

- (instancetype)init {
    self = [super initWithNibName:@"HYWEssenceVC" bundle:nil];    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = HYWColr(223, 223, 223);
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithbg:@"MainTagSubIcon" bgHighlighted:@"MainTagSubIconClick" target:self action:@selector(tag)];
}

- (void)tag
{
    
}

@end
