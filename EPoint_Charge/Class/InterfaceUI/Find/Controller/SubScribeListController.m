//
//  SubScribeListController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/6.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SubScribeListController.h"
#import "MenuView.h"
#import "SubscribeListCell.h"
#import "SubscribeDetailController.h"
#import "SubscribeGunController.h"
#import "SubscribModel.h"
#import <AMapNaviKit/AMapNaviKit.h>

@interface SubScribeListController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MenuView *menuView;
@property(nonatomic,strong)UITableView *siteTableView;

@property(nonatomic,copy)NSArray *data;

// 导航组件
@property(nonatomic,strong)AMapNaviCompositeManager *compositeManager;
@property(nonatomic,strong)AMapNaviCompositeUserConfig *config;

@end

@implementation SubScribeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self startNetworkRequest];
}

#pragma mark - createUI
-(void)createUI
{
    self.tabBarController.tabBar.hidden = YES;
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"电桩列表"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#000000"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self menuView];
    [self siteTableView];
}

#pragma mark - private method
// 返回上一级界面
-(void)popViewController
{
    [_menuView dissFillterView];
    [self.navigationController popViewControllerAnimated:YES];
//    __weak typeof(self) weakSelf = self;
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6/*延迟执行时间*/ * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//
//    });
}

-(void)startNetworkRequest
{
    __weak typeof(self) weakSelf = self;
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixDeviceList];
    NSDictionary *bodyDictionary = @{@"stationId" : self.stationId};
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:NULL withParamDictionary:bodyDictionary successful:^(NSDictionary *result) {
        
        [CustomAlertView hide];
        NSString *code = result[@"code"];
        if ([code integerValue] == RequestNetworkTokenLose) { // token失效
            [super presentLoginController];
            return;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithWarnMessage:result[@"msg"]];
            return;
        }
        NSArray *data = result[@"data"];
        if (data.count == 0) {
            [CustomAlertView showWithWarnMessage:@"暂无数据"];
            return;
        }
        NSDictionary *info = @{@"parkFee" : weakSelf.parkFee, @"place" : weakSelf.location, @"distance" : weakSelf.distance, @"latitude" : weakSelf.latitude, @"longitude" : weakSelf.longitude, @"isSupportOrder" : [NSNumber numberWithBool:weakSelf.isSupportOrder]};
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in data) {
            SubscribModel *model = [SubscribModel modelWithDictionary:dictionary withInfo:info];
            [mutableArray addObject:model];
        }
        weakSelf.data = [mutableArray mutableCopy];
        [weakSelf.siteTableView reloadData];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(MenuView *)menuView
{
    if (!_menuView) {
        CGFloat x = 0.0f;
        CGFloat y = NavigationBarHeight + [GeneralSize getStatusBarHeight];
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 44.0f;
        _menuView = [[MenuView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_menuView];
    }
    return _menuView;
}

-(UITableView *)siteTableView
{
    if (!_siteTableView) {
        CGFloat x = 0.0f;
        CGFloat y = _menuView.frame.origin.y + _menuView.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        _siteTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _siteTableView.delegate = self;
        _siteTableView.dataSource = self;
        _siteTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if ([_siteTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _siteTableView.separatorInset = UIEdgeInsetsZero;
        }
        [self.view addSubview:_siteTableView];
    }
    return _siteTableView;
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

-(NSArray *)data
{
    if (!_data) {
        _data = [[NSArray alloc] init];
    }
    return _data;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SubCellIdentifier = @"SubCellIdentifier";
    SubscribeListCell *cell = [tableView dequeueReusableCellWithIdentifier:SubCellIdentifier];
    if (cell == nil) {
        cell = [[SubscribeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SubCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.data[indexPath.row];
    [cell.navItem addTarget:self action:@selector(navClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.subscribeItem addTarget:self action:@selector(makeAppointmentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
//    SubscribeDetailController *subDetailVC = [findSB instantiateViewControllerWithIdentifier:@"SubscribeDetailController"];
//    [self.navigationController pushViewController:subDetailVC animated:YES];
//}

// 导航
-(void)navClick:(UIButton *)button
{
    UIView *contentView = [button superview];
    SubscribeListCell *cell = (SubscribeListCell *)[contentView superview];
    CGFloat latitude = [cell.model.latitude floatValue];
    CGFloat longitude = [cell.model.longitude floatValue];
    [self.config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:latitude longitude:longitude] name:NULL POIId:NULL];
    [self.compositeManager presentRoutePlanViewControllerWithOptions:self.config];
}

// 预约
-(void)makeAppointmentAction:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    SubscribeListCell *cell = (SubscribeListCell *)[contentView superview];
    [self startAppointment:cell.model.deviceID];
    
//    UIStoryboard *findSB = [UIStoryboard storyboardWithName:@"Find" bundle:[NSBundle mainBundle]];
//    SubscribeGunController *subscribeGunVC = [findSB instantiateViewControllerWithIdentifier:@"SubscribeGunController"];
//    [self.navigationController pushViewController:subscribeGunVC animated:YES];
}

// 启动预约
-(void)startAppointment:(NSString *)deviceId
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixStartAppointment];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"deviceId" : deviceId, @"clientType" : @"IOS"};
    [CustomAlertView show];
//    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *msg = resultDictionary[@"msg"];
        [CustomAlertView showWithWarnMessage:msg];
        return ;
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
        
    }];
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
