//
//  AroundStationController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "AroundStationController.h"
#import "AroundSlideView.h"
#import "AroundCell.h"
#import "AroundModel.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "ListDetailController.h"
#import "SubScribeListController.h"

@interface AroundStationController ()<AroundSlideViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)AroundSlideView *aroundSlideView;
@property(nonatomic,strong)UITableView *aroundTableView;
@property(nonatomic,strong)UIRefreshControl *refreshControl;

@property(nonatomic,strong)NSMutableArray *dataArray; // 数据
@property(nonatomic,assign)NSInteger currentPage; // 当前页数
@property(nonatomic,assign)AroundStationType aroundType;

// 导航组件
@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)AMapNaviCompositeUserConfig *config;

@end

@implementation AroundStationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self startRequestNetwork:self.aroundType andPageNum:self.currentPage];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"周边站点"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#000000"];
    
    
    self.currentPage = 1;
    self.aroundType = AroundStationTypeDistance;
    [self aroundSlideView];
    [self aroundTableView];
    [self refreshControl];
}

#pragma mark - request networking
// 根据类型进行请求
-(void)startRequestNetwork:(AroundStationType)stationType andPageNum:(NSUInteger)pageNum
{
    NSString *latitude = [[UserLocationManager shareInstance] getUserLocationWithLatitude];
    NSString *longitude = [[UserLocationManager shareInstance] getUserLocationWithLongitude];
    
    NSUInteger type = stationType;
    NSString *collation = [NSString stringWithFormat:@"%lu",(unsigned long)type];
    NSNumber *page = [NSNumber numberWithInteger:pageNum];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAroundStation];
    NSDictionary *headerParam = @{@"access_token" : [[UserInfoManager shareInstance] achiveUserInfoAccessToken]};
    NSDictionary *bodyParam = @{@"latitude" : latitude,@"longitude" : longitude,@"collation" : collation,@"pageNum" : page};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDict) {
        if (weakSelf.refreshControl.isRefreshing) {
            [weakSelf.refreshControl endRefreshing];
        }
        
        [CustomAlertView hide];
        
        NSString *code = resultDict[@"code"];
        NSString *msg = resultDict[@"msg"];
        NSArray *data = resultDict[@"data"];
        
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
            weakSelf.currentPage--;
            [CustomAlertView showWithFailureMessage:@"暂无数据"];
            return;
        }
        
//        NSLog(@"%@",data);
        
        for (NSDictionary *dictionary in data) {
            AroundModel *model = [AroundModel modelWithDictionary:dictionary];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.aroundTableView reloadData];
       
    } failure:^(NSError *error) {
        if (self.refreshControl.isRefreshing) {
            [self.refreshControl endRefreshing];
        }
        weakSelf.currentPage--;
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
        return;
    }];
}

-(void)refreshAction
{
    if (self.refreshControl.isRefreshing) {
        self.currentPage++;
        [self startRequestNetwork:self.aroundType andPageNum:self.currentPage];
    }
}

#pragma mark - lazy load
-(AroundSlideView *)aroundSlideView
{
    if (!_aroundSlideView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 44.0f;
        
        _aroundSlideView = [[AroundSlideView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _aroundSlideView.delegate = self;
        [self.view addSubview:_aroundSlideView];
    }
    return _aroundSlideView;
}

-(UITableView *)aroundTableView
{
    if (!_aroundTableView) {
        CGFloat x = 0.0f;
        CGFloat y = _aroundSlideView.frame.origin.y + _aroundSlideView.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y - 5.0f;
        
        _aroundTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _aroundTableView.delegate = self;
        _aroundTableView.dataSource = self;
        _aroundTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_aroundTableView];
    }
    return _aroundTableView;
}

-(UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
        [_aroundTableView addSubview:_refreshControl];
    }
    return _refreshControl;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(AMapNaviCompositeManager *)compositeManager
{
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];
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

#pragma mark - AroundSlideViewDelegate
// 点击切换按钮
-(void)getAroundSlideSelectedIndex:(NSInteger)selectIndex
{
    self.currentPage = 1;
    self.aroundType = (selectIndex == 0) ? AroundStationTypeDistance : AroundStationTypeIdel;
    [self.dataArray removeAllObjects];
    [self startRequestNetwork:self.aroundType andPageNum:self.currentPage];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DistanceCellIdentifier = @"DistanceCellIdentifier";
    AroundCell *cell = [tableView dequeueReusableCellWithIdentifier:DistanceCellIdentifier];
    if (cell == nil) {
        cell = [[AroundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DistanceCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.dataArray[indexPath.row];
    [cell.navItem addTarget:self action:@selector(navClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}

#pragma mark - click
-(void)navClick:(UIButton *)button
{
    UIView *contentView = [button superview];
    AroundCell *cell = (AroundCell *)[contentView superview];
    NSIndexPath *indexPath = [_aroundTableView indexPathForCell:cell];
    
    AroundModel *model = self.dataArray[indexPath.row];
    NSString *latitudeStr = model.latitude;
    NSString *longitudeStr = model.longitude;
    
    CGFloat latitude = [latitudeStr floatValue];
    CGFloat longitude = [longitudeStr floatValue];
    [self.config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:latitude longitude:longitude] name:NULL POIId:NULL];
    [self.compositeManager presentRoutePlanViewControllerWithOptions:self.config];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AroundModel *model = self.dataArray[indexPath.row];
    
    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
    SubScribeListController *subVC = [findSB instantiateViewControllerWithIdentifier:@"SubScribeListController"];
    subVC.stationId = [NSString stringWithFormat:@"%ld",(long)model.stationID]; // 站点ID
    subVC.parkFee = model.parkFee;
    subVC.distance = model.distance;
    subVC.location = model.place;
    subVC.latitude = model.latitude;
    subVC.longitude = model.longitude;
    subVC.isSupportOrder = model.isSupportOrder;
    [self.navigationController pushViewController:subVC animated:YES];
    
//    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
//    ListDetailController *listDetailVC = [findSB instantiateViewControllerWithIdentifier:@"ListDetailController"];
//    listDetailVC.model = model;
//    [self.navigationController pushViewController:listDetailVC animated:YES];
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
