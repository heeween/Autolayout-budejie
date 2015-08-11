//
//  HYWCommentController.m
//  百思不得姐
//
//  Created by heew on 15/8/2.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWCommentController.h"
#import "HYWComment.h"
#import "HYWUser.h"
#import "HYWTopicCell.h"
#import "HYWCommnetHeaderFooter.h"
#import "HYWCommentCell.h"
#import "HYWTopic.h"

@interface HYWCommentController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray; /**全部评论模型数组 */
@property (nonatomic, strong) NSArray *hotCommentArray; /**最热评论模型数 */
@property (nonatomic, strong) HYWComment *top_Cmt; /**记录最新评论 */
@property (nonatomic, assign) NSInteger page; /**记录加载更多数据的页数 */
@property (nonatomic, strong) AFHTTPSessionManager *manager; /**网络管理器 */
@end

@implementation HYWCommentController
- (NSArray *)hotCommentArray
{
    if (_hotCommentArray == nil) {
        _hotCommentArray = [NSArray array];
    }
    return _hotCommentArray;
}

- (NSMutableArray *)commentArray
{
    if (_commentArray == nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.header beginRefreshing];
    self.tableView.header.autoChangeAlpha = YES;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.footer.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 10, 0);
    self.tableView.backgroundColor = HYWColr(223, 223, 223);
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.top_Cmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
}


- (void)loadNewData {
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"data_id"] = self.ID;
    param[@"hot"] = @"1";
    self.page = 1;
    [self.manager GET:kBaseUrl parameters:param success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        // 没有数据,服务器返回为array
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.header endRefreshing];
            return;
        }
        self.commentArray = [HYWComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotCommentArray = [HYWComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        self.page++;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

- (void)loadMoreData {
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"data_id"] = self.ID;
    param[@"hot"] = @"1";
    HYWComment *comment = [self.commentArray lastObject];
    param[@"lastcid"] = comment.ID;
    param[@"page"] = @(self.page);
    [self.manager GET:kBaseUrl parameters:param success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        // 没有数据,服务器返回为array
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.footer.hidden = YES;
            return;
        }
        self.hotCommentArray = [HYWComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        [self.commentArray addObjectsFromArray:[HYWComment objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        self.page++;
        if (self.commentArray.count == [responseObject[@"total"] integerValue]) {
            [self.tableView.footer noticeNoMoreData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - 监听TableView让键盘退出
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect keyboardEndFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    self.bottomSpaceConstraint.constant = HYWScreenH - keyboardEndFrame.origin.y;
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - datasource
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotCommentArray.count > 0) {
        return 3;
    }else if (self.commentArray.count > 0) {
        return 2;
    } else {
        return 1;
    }
}

// 每一组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.hotCommentArray.count > 0) {
        if (section == 0) {
            return 1;
        }else if (section == 1) {
            return self.hotCommentArray.count;
        }else {
            return self.commentArray.count;
        }
    }else if (self.commentArray.count > 0) {
        if (section == 0) {
            return 1;
        }else {
            return self.commentArray.count;
        }
    } else {
        return 1;
    }
}

// 每一个行的细节
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.hotCommentArray.count > 0) {
        if (indexPath.section == 0) {
            HYWTopicCell *cell = [HYWTopicCell cellWithTableView:tableView];
            cell.topic = self.topic;
            return cell;
        }else if (indexPath.section == 1) {
            HYWCommentCell *cell = [HYWCommentCell cellWithTableView:tableView];
            HYWComment *comment = self.hotCommentArray[indexPath.row];
            cell.comment = comment;
            return cell;
        }else {
            HYWCommentCell *cell = [HYWCommentCell cellWithTableView:tableView];
            HYWComment *comment = self.commentArray[indexPath.row];
            cell.comment = comment;
            return cell;
        }
    }else if (self.commentArray.count > 0) {
        if (indexPath.section == 0) {
            HYWTopicCell *cell = [HYWTopicCell cellWithTableView:tableView];
            cell.topic = self.topic;
            return cell;
        }else {
            HYWCommentCell *cell = [HYWCommentCell cellWithTableView:tableView];
            HYWComment *comment = self.commentArray[indexPath.row];
            cell.comment = comment;
            return cell;
        }
    } else {
        HYWTopicCell *cell = [HYWTopicCell cellWithTableView:tableView];
        cell.topic = self.topic;
        return cell;
    }
}


#pragma mark - Delegate代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else {
        return 18;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.hotCommentArray.count > 0) {
        if (section == 0) {
            return nil;
        }else if (section == 1) {
            HYWCommnetHeaderFooter *headerFooter = [HYWCommnetHeaderFooter HeaderFooterViewWithTableView:tableView];
            headerFooter.title = @"热门评论";
            return headerFooter;
        }else {
            HYWCommnetHeaderFooter *headerFooter = [HYWCommnetHeaderFooter HeaderFooterViewWithTableView:tableView];
            headerFooter.title = @"最新评论";
            return headerFooter;
        }
    }else if (self.commentArray.count > 0) {
        if (section == 0) {
            return nil;
        }else {
            HYWCommnetHeaderFooter *headerFooter = [HYWCommnetHeaderFooter HeaderFooterViewWithTableView:tableView];
            headerFooter.title = @"最新评论";
            return headerFooter;
        }
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HYWCommentCell *cell =(HYWCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 显示MenuController
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    menu.menuItems = @[ding, replay, report];
    CGRect rect = CGRectMake(0, cell.viewHeight * 0.5, cell.viewWidth, cell.viewHeight * 0.5);
    [menu setTargetRect:rect inView:cell];    [menu setMenuVisible:YES animated:YES];
    
}

#pragma mark - MenuItem处理
- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HYWLog(@"%@",indexPath);
}

- (void)replay:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HYWLog(@"%@",indexPath);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HYWLog(@"%@",indexPath);
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.topic.top_cmt = self.top_Cmt;
}
@end
