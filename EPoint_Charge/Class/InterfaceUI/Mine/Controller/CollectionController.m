//
//  CollectionController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CollectionController.h"
#import "DefaultView.h"
#import "CollectCell.h"
#import "CollectModel.h"
#import <AMapNaviKit/AMapNaviKit.h>

NSString *const CollectDefaultImageName = @"default_collection"; // 收藏缺省页图片名字
CGFloat const CollectTableRowHeight = 139.0f; // 单元格高度

@interface CollectionController ()<UITableViewDelegate,UITableViewDataSource,AMapNaviCompositeManagerDelegate>

@property(nonatomic,strong)UITableView *collectTableView;
@property(nonatomic,strong)NSMutableArray *collects;
@property(nonatomic,assign)NSInteger currentPage; // 当前页数

@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)AMapNaviCompositeUserConfig *config;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self startRequestNetWorkWithPage:self.currentPage withPerNum:PerPageNum];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - private method
-(void)startRequestNetWorkWithPage:(NSInteger)page withPerNum:(NSInteger)perNum
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixCollectStation];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSString *pageNum = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *pageSize = [NSString stringWithFormat:@"%ld",(long)perNum];
    NSString *latitude = [[UserLocationManager shareInstance] getUserLocationWithLatitude];
    NSString *longitude = [[UserLocationManager shareInstance] getUserLocationWithLongitude];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"pageNum" : pageNum,
                                @"pageSize" : pageSize,
                                @"latitude" : latitude,
                                @"longitude" : longitude};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        NSArray *data = resultDictionary[@"data"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            weakSelf.currentPage--;
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            weakSelf.currentPage--;
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        if (data.count == 0) {
            (weakSelf.currentPage == 1) ? [[DefaultView shareInstance] setSuperView:weakSelf.view withDefaultImageNamed:CollectDefaultImageName withTitle:@"亲，您还没有收藏哦"] : [CustomAlertView showWithWarnMessage:@"暂无数据"];
            weakSelf.currentPage--;
            return;
        }
        
        for (NSDictionary *dictionary in data) {
            CollectModel *model = [CollectModel modelWithDictionary:dictionary];
            [weakSelf.collects addObject:model];
        }
        [weakSelf.collectTableView reloadData];
        
    } failure:^(NSError *error) {
        weakSelf.currentPage--;
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
        if (weakSelf.collects.count == 0) {
            [[DefaultView shareInstance] setSuperView:self.view withDefaultImageNamed:CollectDefaultImageName withTitle:@"亲，您还没有收藏哦"];
        }
    }];
}

#pragma mark - lazy load
-(UITableView *)collectTableView
{
    if (!_collectTableView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _collectTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _collectTableView.delegate = self;
        _collectTableView.dataSource = self;
        _collectTableView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
        // 补全分割线
        if ([_collectTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _collectTableView.separatorInset = UIEdgeInsetsZero;
        }
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], 12.0f)];
        headerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
        _collectTableView.tableHeaderView = headerView;
        _collectTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_collectTableView];
    }
    return _collectTableView;
}

-(NSArray *)collects
{
    if (!_collects) {
        _collects = [[NSMutableArray alloc] init];
    }
    return _collects;
}

-(AMapNaviCompositeManager *)compositeManager
{
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];
        _compositeManager.delegate = self;
    }
    return _compositeManager;
}

-(AMapNaviCompositeUserConfig *)config
{
    if (!_config) {
        _config = [[AMapNaviCompositeUserConfig alloc] init];
    }
    return _config;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"我的收藏"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    self.currentPage = 1;
    
    [self compositeManager];
    [self config];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CollectTableRowHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CollectCellIdentifier = @"CollectCellIdentifier";
    CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectCellIdentifier];
    if (cell == nil) {
        cell = [[CollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CollectCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.collects[indexPath.row];
    [cell.navItem addTarget:self action:@selector(navClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - click
-(void)navClick:(UIButton *)button
{
    UIView *contentView = [button superview];
    CollectCell *cell = (CollectCell *)[contentView superview];
    
    CGFloat latitude = [cell.model.latitude floatValue];
    CGFloat longitude = [cell.model.longitude floatValue];
    [self.config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:latitude longitude:longitude] name:NULL POIId:NULL];
    [self.compositeManager presentRoutePlanViewControllerWithOptions:self.config];
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
