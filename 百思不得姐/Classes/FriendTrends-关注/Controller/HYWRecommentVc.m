//
//  HYWRecommentVc.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWRecommentVc.h"
#import "HYWRecommendCategoryCell.h"
#import "HYWRecommendCategory.h"
#import "HYWRecommendUserDelegate.h"
#import "HYWRecommendUser.h"




@interface HYWRecommentVc () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *recommendUserTableView;
@property (nonatomic, strong) HYWRecommendUserDelegate *recommendUserDelegate; /**推荐详情代理 */
@property (nonatomic, strong) NSArray *categerys; /**左侧推荐分类模型数组 */
@property (nonatomic, strong) AFHTTPSessionManager *manager; /**网络请求管理 */
@property (nonatomic, strong) NSMutableDictionary *params; /**请求头 */
@end






@implementation HYWRecommentVc

- (NSMutableDictionary *)params
{
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _manager;
} // 懒加载网络请求管理,并设置超时



- (HYWRecommendUserDelegate *)recommendUserDelegate {
    if (_recommendUserDelegate == nil) {
        _recommendUserDelegate = [[HYWRecommendUserDelegate alloc] init];
    }
    return _recommendUserDelegate;
} // 第三方代理懒加载



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self sendHTTPSession];
} // view加载后操作


- (void)sendHTTPSession {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [HYWRecommendCategory setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        self.categerys = [HYWRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone]; //默认左边TableView选中第一行
        [self.recommendUserTableView.header beginRefreshing]; // 刷新对应右边的数据
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络加载失败"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
} // 加载载左侧列表数据



- (void)setUp {
    self.view.backgroundColor = HYWColr(223, 223, 223);
    self.navigationItem.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.recommendUserTableView.contentInset = self.categoryTableView.contentInset;
    self.recommendUserTableView.dataSource = self.recommendUserDelegate;
    self.recommendUserTableView.delegate = self.recommendUserDelegate;
    self.recommendUserTableView.rowHeight = 70;
    self.recommendUserTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUsersWithMJRefresh:)];
    self.recommendUserTableView.footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadUsersWithMJRefresh:)];
   
} // 设置TableView



- (void)loadUsersWithMJRefresh:(MJRefreshComponent *)refresh {
    HYWRecommendCategory *recommendCategory = self.categerys[[self.categoryTableView indexPathForSelectedRow].row];
    self.recommendUserDelegate.recommentdCategory = recommendCategory;

    
    
    
    // 判断是头部刷新还是底部刷新
    if (refresh == self.recommendUserTableView.footer) { // 如果是底部每次刷新增加
        ++recommendCategory.currentPage;
    }else {
        [recommendCategory.users removeAllObjects]; // 如果是头部刷新移除以前所有数据
        recommendCategory.currentPage = 1; // 其他情况都只刷新第一页
    }
    
    
    
    
    // 拼接请求头
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([recommendCategory.ID integerValue]);
    params[@"page"] = @(recommendCategory.currentPage);
    self.params = params;
    
    
    
    
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [recommendCategory.users addObjectsFromArray:[HYWRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        recommendCategory.total = [responseObject[@"total"] integerValue];
        if (self.params !=params) return ; // 如果是上次请求,不刷新界面
        [self.recommendUserTableView reloadData];
        [refresh endRefreshing];
        if (recommendCategory.users.count == recommendCategory.total) [self.recommendUserTableView.footer noticeNoMoreData]; // 如果加载完毕,更换底部控件提示
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络加载失败" maskType:SVProgressHUDMaskTypeBlack];
        [refresh endRefreshing];
    }];
}


#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categerys.count;
} // 左侧每一组的行数




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HYWRecommendCategoryCell *cell = [HYWRecommendCategoryCell cellWithTableView:tableView];
    HYWRecommendCategory *recommendCategory = self.categerys[indexPath.row];
    cell.recommendCategory = recommendCategory;
    return cell;
    
} // 左侧每一个行的细节




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HYWRecommendCategory *recommendCategory = self.categerys[indexPath.row];
    self.recommendUserDelegate.recommentdCategory = recommendCategory;
    [self.recommendUserTableView.footer endRefreshing]; // 清除上一次底部刷新控件状态
    [self.recommendUserTableView reloadData]; // 刷新上一次显示的信息
    if (recommendCategory.users.count == 0) {
        [self.recommendUserTableView.header beginRefreshing];
    }
}

@end






