//
//  MineViewController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/15.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MineViewController.h"
#import "MTopView.h"
#import "MAccountView.h"
#import "MineCell.h"
#import "RechargeController.h"
#import "RefundController.h"

CGFloat const MTopBGViewHeight = 214.0f;
CGFloat const TableViewRowHeight = 65.0f;
CGFloat const TableViewHeaderHeight = 276.0f; //tableview header 高度
CGFloat const AccountViewHeight = 100.0f; // 账户高度

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MAccountDelegate>

@property(nonatomic,strong)MTopView *topImageView; // 顶部背景图
@property(nonatomic,strong)MAccountView *accountView; // 账户
@property(nonatomic,strong)UITableView *mineTableView;
@property(nonatomic,strong)UIRefreshControl *refreshControl;

@property(nonatomic,strong)NSArray *icons; // 数据

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [super setNavigationBarClearStyle];
    [self startRequestNetwork];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - lazy load
-(MTopView *)topImageView
{
    if (!_topImageView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = MTopBGViewHeight;
        
        _topImageView = [[MTopView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    }
    return _topImageView;
}

-(MAccountView *)accountView
{
    if (!_accountView) {
        CGFloat x = 15.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 100.0f;
        CGFloat y = MTopBGViewHeight - height / 2;
        
        _accountView = [[MAccountView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_accountView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5.0f, 5.0f)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _accountView.bounds;
        maskLayer.path = maskPath.CGPath;
        _accountView.layer.mask = maskLayer;
        _accountView.delegate = self;
    }
    return _accountView;
}

-(UITableView *)mineTableView
{
    if (!_mineTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - TabBarHeight;
        
        _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _mineTableView.delegate = self;
        _mineTableView.dataSource = self;
        _mineTableView.separatorInset = UIEdgeInsetsMake(0, 36, 0, 36);
        _mineTableView.separatorColor = [UIColor colorWithHexString:@"#CCCCCC"];
        _mineTableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_mineTableView];
    }
    return _mineTableView;
}

-(UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshEvent) forControlEvents:UIControlEventValueChanged];
        [_mineTableView addSubview:_refreshControl];
    }
    return _refreshControl;
}

-(NSArray *)icons
{
    if (!_icons) {
        _icons = @[
                   @{@"imageName" : @"mine_order" , @"title" : @"历史订单"},
                   @{@"imageName" : @"mine_collect" , @"title": @"我的收藏"},
                   @{@"imageName" : @"mine_message" , @"title" : @"我的消息"},
//                   @{@"imageName" : @"mine_about" , @"title" : @"关于我们"},
//                   @{@"imageName" : @"mine_company_introduce" , @"title" : @"公司简介"},
                   @{@"imageName" : @"mine_evaluate" , @"title" : @"意见反馈"},
                   @{@"imageName" : @"mine_setting" , @"title" : @"设置"}];
    }
    return _icons;
}

#pragma mark - private method
-(void)initUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    [self mineTableView];
    [self refreshControl];
    [self topImageView]; // 顶部视图
    [self accountView];
    
    if (@available(iOS 11.0, *)) {
        self.mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 添加header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], TableViewHeaderHeight)];
    [headerView addSubview:_topImageView];
    [headerView addSubview:_accountView];
    self.mineTableView.tableHeaderView = headerView;
}

-(void)refreshEvent
{
    if (_refreshControl.refreshing) {
        [self startRequestNetwork];
    }
}

-(void)startRequestNetwork
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixUserInfo];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerDictionary = @{@"access_token" : accessToken};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
        
        if (weakSelf.refreshControl.refreshing) {
            [weakSelf.refreshControl endRefreshing];
        }
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        if ([code integerValue] == RequestNetworkTokenLose) { // token失效
            [super presentLoginController];
            return;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithWarnMessage:resultDictionary[@"msg"]];
            return;
        }
        NSDictionary *data = resultDictionary[@"data"];
        [weakSelf.topImageView.headImageView loadNetworkImageWithURL:data[@"image"] placeholderImageWithImageName:@"login_logo"];
        double balance = [data[@"balance"] floatValue] / 100;
        weakSelf.accountView.moneyLabel.text = [NSString stringWithFormat:@"%.2f",balance]; // 账户余额
        
    } failure:^(NSError *error) {
        if (weakSelf.refreshControl.refreshing) {
            [weakSelf.refreshControl endRefreshing];
        }
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MineVCTableCellIdentifier";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        [cell.bgImageView setImage:[UIImage imageNamed:@"mine_cell_top"]];
    } else if (indexPath.row == (self.icons.count - 1)) {
        [cell.bgImageView setImage:[UIImage imageNamed:@"mine_cell_bottom"]];
    }
    
    NSString *imageName = [[self.icons objectAtIndex:indexPath.row] objectForKey:@"imageName"];
    NSString *title = [[self.icons objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.icon.image = [UIImage imageNamed:imageName];
    cell.title.text =title;
    
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableViewRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *targetVCName = @"";
    
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    
    switch (indexPath.row) {
        case 0:
            targetVCName = @"HistoryOrderController";
            break;
        case 1:
            targetVCName = @"CollectionController";
            break;
        case 2:
            targetVCName = @"MessageController";
            break;
        case 3:
            targetVCName = @"FeedBackController";
            break;
        case 4:
            targetVCName = @"SetupController";
            break;
        default:
            break;
    }

    UIViewController *targetVC = [mineSB instantiateViewControllerWithIdentifier:targetVCName];
    [self.navigationController pushViewController:targetVC animated:YES];
}

#pragma mark - MAccountDelegate
-(void)accountRecharge
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    RechargeController *rechargeVC = [mineSB instantiateViewControllerWithIdentifier:@"RechargeController"];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}

-(void)accountReFund
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    RefundController *refundVC = [mineSB instantiateViewControllerWithIdentifier:@"RefundController"];
    refundVC.balance = [self.accountView.moneyLabel.text copy];
    [self.navigationController pushViewController:refundVC animated:YES];
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
