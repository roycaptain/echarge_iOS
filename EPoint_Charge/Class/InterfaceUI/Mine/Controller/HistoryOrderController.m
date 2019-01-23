//
//  HistoryOrderController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "HistoryOrderController.h"
#import "HistoryOrderCell.h"
#import "DefaultView.h"
#import "HistoryOrder.h"

CGFloat const HistoryTableRowHeight = 98.0f; // 历史订单表格cell的高度
NSString *const DefaultHistoryOrderImageName = @"default_history_order"; // 历史订单缺省页图片名字

@interface HistoryOrderController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *orderTableView;
@property(nonatomic,strong)UIRefreshControl *refreshControl;

@property(nonatomic,strong)NSMutableArray *orderData;
@property(nonatomic,assign)NSUInteger currentPage; // 当前页数

@end

@implementation HistoryOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self startRequestNetworkWithPageNum:self.currentPage withPerPageNum:PerPageNum];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - private method
-(void)startRequestNetworkWithPageNum:(NSUInteger)pageNum withPerPageNum:(NSUInteger)perPageNum
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixHistoryOrder];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSString *pageNumStr = [NSString stringWithFormat:@"%lu",(unsigned long)pageNum];
    NSString *perPageNumStr = [NSString stringWithFormat:@"%lu",(unsigned long)perPageNum];

    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"pageNum" : pageNumStr,@"pageSize" : perPageNumStr};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [weakSelf.refreshControl endRefreshing];
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        NSArray *data = resultDictionary[@"data"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            weakSelf.currentPage--;
            [super presentLoginController];
            return;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            weakSelf.currentPage--;
            [CustomAlertView showWithWarnMessage:msg];
            return;
        }
        if (data.count == 0) {
            weakSelf.currentPage == 1 ? [[DefaultView shareInstance] setSuperView:weakSelf.view withDefaultImageNamed:DefaultHistoryOrderImageName withTitle:@"亲，您还没有订单哦"] : [CustomAlertView showWithWarnMessage:@"暂无数据"];
            weakSelf.currentPage--;
            return;
        }
        
        for (NSDictionary *dictionary in data) {
            HistoryOrder *model = [HistoryOrder modelWithDictionary:dictionary];
            [weakSelf.orderData addObject:model];
        }
        
        [weakSelf.orderTableView reloadData];
    } failure:^(NSError *error) {
        weakSelf.currentPage--;
        [weakSelf.refreshControl endRefreshing];
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
        if (weakSelf.orderData.count == 0) {
            [[DefaultView shareInstance] setSuperView:weakSelf.view withDefaultImageNamed:DefaultHistoryOrderImageName withTitle:@"亲，您还没有订单哦"];
            return;
        }
    }];
}

-(void)refreshAction
{
    if (_refreshControl.refreshing) {
        self.currentPage++;
        [self startRequestNetworkWithPageNum:self.currentPage withPerPageNum:PerPageNum];
    }
}

#pragma mark - lazy load
-(UITableView *)orderTableView
{
    if (!_orderTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 64.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - NavigationBarHeight;
        
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//隐藏分割线
        _orderTableView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
        [self.view addSubview:_orderTableView];
    }
    return _orderTableView;
}

-(UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
        [_orderTableView addSubview:_refreshControl];
    }
    return _refreshControl;
}

-(NSMutableArray *)orderData
{
    if (!_orderData) {
        _orderData = [[NSMutableArray alloc] init];
    }
    return _orderData;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"历史交易订单"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    _currentPage = 1;
    [self orderTableView];
    [self refreshControl];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HistoryTableRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *HistoryOrderCellIdentifier = @"HistoryOrderCellIdentifier";
    HistoryOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryOrderCellIdentifier];
    if (cell == nil) {
        cell = [[HistoryOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HistoryOrderCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.orderData[indexPath.row];
    
    return cell;
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
