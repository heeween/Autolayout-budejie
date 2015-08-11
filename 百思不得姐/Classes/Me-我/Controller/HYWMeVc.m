//
//  HYWMeVc.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWMeVc.h"
#import "HYWSquare.h"
#import "HYWMeCell.h"
#import "HYWSquareFooterView.h"


@interface HYWMeVc ()
@property (nonatomic, strong) NSArray *squares; /**方块模型数组 */
@end
@implementation HYWMeVc

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBasic];
    [self setupTableView];
}

- (void)sendHTTPRequest {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"square";
    param[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:kBaseUrl parameters:param success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        HYWSquareFooterView *footerView = (HYWSquareFooterView *)self.tableView.tableFooterView;
        footerView.squares = [HYWSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        nil;
    }];
}

- (void)setupTableView {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendHTTPRequest)];
    HYWSquareFooterView *footerView = [[HYWSquareFooterView alloc] init];
    self.tableView.tableFooterView = footerView;
    [self.tableView.header beginRefreshing];
}

- (void)setupBasic {
    self.view.backgroundColor = HYWColr(223, 223, 223);
    self.navigationItem.title = @"我的";
    UIBarButtonItem *barButtonItem1 = [UIBarButtonItem itemWithbg:@"mine-setting-icon" bgHighlighted:@"mine-setting-icon-click" target:self action:@selector(mine_Setting_Click)];
    UIBarButtonItem *barButtonItem2 = [UIBarButtonItem itemWithbg:@"mine-moon-icon" bgHighlighted:@"mine-moon-icon-click" target:self action:@selector(mine_Sun_Click)];
    self.navigationItem.rightBarButtonItems = @[barButtonItem1,barButtonItem2];

}
#pragma mark - datasource
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// 每一组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// 每一个行的细节
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYWMeCell *cell = [HYWMeCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
        cell.textLabel.text = @"登陆/注册";
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (void)mine_Sun_Click
{
    
}
- (void)mine_Setting_Click
{
    
}
@end
