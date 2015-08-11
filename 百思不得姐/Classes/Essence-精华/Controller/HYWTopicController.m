//
//  HYWTextController.m
//  百思不得姐
//
//  Created by heew on 14/7/26.
//  Copyright (c) 2014年 adhx. All rights reserved.
//

#import "HYWTopicController.h"
#import "HYWTopic.h"
#import "HYWTopicCell.h"
#import "HYWCommentController.h"
#import "HYWNewVC.h"
#import "HYWNavController.h"

@interface HYWTopicController ()
@property (nonatomic, strong) NSMutableArray *topics; /**字典数组 */
@property (nonatomic, assign) NSInteger page; /**当前页码 */
@property (nonatomic, copy) NSString *maxtime; /**记录上一次的maxtime  */
@property (nonatomic, strong) NSDictionary *parmas; /**记录上一次的请求 */
@property (nonatomic, assign) NSInteger lastIndex; /**记录上一次选中的索引 */


@end

@implementation HYWTopicController

- (NSMutableArray *)topics {
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = HYWScreenBounds;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUpTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(HYWTabBarClick) name:HYWTabBarButtonClick object:nil];
} //

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TabBar通知监听方法
- (void)HYWTabBarClick {
    if (self.tabBarController.selectedIndex == self.lastIndex && [self.view isShowingOnKeyWindow]) {
        [self.tableView.header beginRefreshing];
    }
    self.lastIndex = self.tabBarController.selectedIndex;
}


- (void)setUpTableView {
    self.tableView.contentInset = UIEdgeInsetsMake(99, 0, 44, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData:)];
    [self.tableView.header beginRefreshing];
    self.tableView.header.autoChangeAlpha = YES;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData:)];
    self.tableView.estimatedRowHeight = 250;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = HYWColr(223, 223, 223);
} // 设置TableView

- (NSString *)a {
    return [self.parentViewController isKindOfClass:[HYWNewVC class]] ? @"newlist" : @"list";
}

- (void)loadData:(MJRefreshComponent *)refresh {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        if (self.maxtime) {
            params[@"maxtime"] = self.maxtime;
        }
        params[@"page"] = @(self.page++);
    }else {
        self.page = 0;
        params[@"page"] = @(self.page);
    }
    self.parmas = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:kBaseUrl parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if (self.parmas != params) return ;
        if (self.page == 0) self.topics = nil;
        [self.topics addObjectsFromArray:[HYWTopic objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [refresh endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [refresh endRefreshing];
    }];
} // 加载数据



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYWTopicCell *cell = [HYWTopicCell cellWithTableView:tableView];
    HYWTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HYWCommentController *commentVc = [[HYWCommentController alloc] init];
    commentVc.ID = [self.topics[indexPath.row] ID];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}

@end
