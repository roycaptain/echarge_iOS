//
//  SelectChargeController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/8.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SelectChargeController.h"
#import "ChargeCell.h"
#import "DeviceModel.h"
#import "ChargingController.h"

NSString *const ChargeCellIdentifier = @"ChargeCellIdentifier";

@interface SelectChargeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *selectCollectView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)UIButton *startChargeItem; // 开始充电按钮

@property(nonatomic,strong)NSArray *devices; // 数据

@end

@implementation SelectChargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self startNetworkRequest];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItemWithTarget:self action:@selector(backToRootClick)];
    [super setNavigationTitle:@"选择充电枪"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    [self layout];
    [self selectCollectView];
    [_selectCollectView registerClass:[ChargeCell class] forCellWithReuseIdentifier:ChargeCellIdentifier];
    
    [self startChargeItem];
}

#pragma mark - lazy load
-(UICollectionViewLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 17.0f; // item 纵间距
        _layout.minimumInteritemSpacing = 24.0f; // item之间 行间距
    }
    return _layout;
}

-(UICollectionView *)selectCollectView
{
    if (!_selectCollectView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 40.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y - TabBarHeight - 44.0f;
        
        _selectCollectView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:_layout];
        _selectCollectView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _selectCollectView.delegate = self;
        _selectCollectView.dataSource = self;
        [self.view addSubview:_selectCollectView];
    }
    return _selectCollectView;
}

-(UIButton *)startChargeItem
{
    if (!_startChargeItem) {
        CGFloat x = 34.0f;
        CGFloat height = 44.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height - TabBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        
        _startChargeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _startChargeItem.frame = CGRectMake(x, y, width, height);
        [_startChargeItem setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_startChargeItem setTitle:@"开始充电" forState:UIControlStateNormal];
        _startChargeItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_startChargeItem setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_startChargeItem addTarget:self action:@selector(startChargeClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_startChargeItem];
    }
    return _startChargeItem;
}

-(NSArray *)devices
{
    if (!_devices) {
        _devices = [[NSArray alloc] init];
    }
    return _devices;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 每个item的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat FilterCellItemWidth = ([GeneralSize getMainScreenWidth] - 71.0f) / 2;
    return CGSizeMake(FilterCellItemWidth, 34.0f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.devices.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChargeCell *cell = (ChargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ChargeCellIdentifier forIndexPath:indexPath];
    
    DeviceModel *model = self.devices[indexPath.row];
    cell.titleLabel.text = model.deviceName;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSInteger i = 0; i < self.devices.count;i++) {
        if (i == indexPath.item) {
            [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }else {
            [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
        }
    }
}

#pragma mark - private method
-(void)startNetworkRequest
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixChildDeviceSerial];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"deviceSerialNum" : self.deviceSerialNum};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDic) {
        [CustomAlertView hide];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"msg"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        NSArray *data = resultDic[@"data"];
        if (data.count == 0) {
            [CustomAlertView showWithFailureMessage:@"暂无数据"];
            return;
        }
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in data) {
            DeviceModel *model = [DeviceModel modelWithDictionary:dictionary];
            [mutableArray addObject:model];
        }
        weakSelf.devices = [mutableArray mutableCopy];
        [weakSelf.selectCollectView reloadData];
//        [weakSelf.selectCollectView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - click action
// 开始充电
-(void)startChargeClick
{
    if ([[self.selectCollectView indexPathsForSelectedItems] count] == 0) {
        [CustomAlertView showWithWarnMessage:@"请选择充电枪"];
        return;
    }
    
    NSIndexPath *indexPath = [self.selectCollectView indexPathsForSelectedItems][0];
    DeviceModel *model = self.devices[indexPath.row];
    NSString *childDeviceSerialNum = [NSString stringWithFormat:@"%@",model.serialnum];
    NSString *deviceSerialNum = [NSString stringWithFormat:@"%@",self.deviceSerialNum];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixStartCharge];
    NSString *accrssToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accrssToken};
    NSDictionary *bodyParam = @{@"childDeviceSerialNum" : childDeviceSerialNum,@"deviceSerialNum" : deviceSerialNum,@"clientType" : @"IOS"};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        [CustomAlertView hide];
        NSString *code = result[@"code"];
        NSString *msg = result[@"msg"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
            [alert addAction:action];
            [weakSelf presentViewController:alert animated:YES completion:NULL];
            return;
        }
        
        [[UserInfoManager shareInstance] saveUserStartChargeStatus:YES];
        UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
        ChargingController *chargingVC = [chargingSB instantiateViewControllerWithIdentifier:@"ChargingController"];
        [weakSelf.navigationController pushViewController:chargingVC animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"error - %@",error);
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

-(void)backToRootClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
