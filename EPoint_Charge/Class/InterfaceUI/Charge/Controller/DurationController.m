//
//  DurationController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "DurationController.h"
#import "ChargeCell.h"
#import "DurationModel.h"
#import "ChargingController.h"
#import "RechargeController.h"

NSString *const DurationCellIdentifier = @"DurationCellIdentifier";

@interface DurationController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *selectCollectView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;

@property(nonatomic,strong)UIButton *startChargeItem; // 开始充电按钮
@property(nonatomic,strong)UILabel *feeLabel;

@property(nonatomic,assign)CGFloat price; // 单价
@property(nonatomic,assign)CGFloat account; // 账户余额

@property(nonatomic,copy)NSArray *data; // 数据

@end

@implementation DurationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    NSArray *arr = @[@{@"name" : @"0.5小时", @"value" : @"0.5"},
                     @{@"name" : @"1小时", @"value" : @"1"},
                     @{@"name" : @"2小时", @"value" : @"2"},
                     @{@"name" : @"3小时", @"value" : @"3"},
                     @{@"name" : @"5小时", @"value" : @"5"},
                     @{@"name" : @"8小时", @"value" : @"8"},
                     @{@"name" : @"10小时", @"value" : @"10"},
                     @{@"name" : @"12小时", @"value" : @"12"}];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in arr) {
        DurationModel *model = [DurationModel modelWithDictionary:dictionary];
        [mutableArray addObject:model];
    }
    self.data = [mutableArray mutableCopy];
    [_selectCollectView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.type == 3) {
        _price = 0.0f;
        _account = 0.0f;
        [self getDeviceTemplate];
        [self getUserAccount];
    }
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"选择充电时长"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    [self feeLabel];
    [self layout];
    [self selectCollectView];
    [_selectCollectView registerClass:[ChargeCell class] forCellWithReuseIdentifier:DurationCellIdentifier];
    [self startChargeItem];
    [self data];
}

#pragma mark - lazy load
-(UILabel *)feeLabel
{
    if (!_feeLabel) {
        CGFloat x = 10.0f;
        CGFloat height = 40.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 10.0f;
        CGFloat width = ([GeneralSize getMainScreenWidth] - x * 2) / 2;
        
        _feeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _feeLabel.font = [UIFont systemFontOfSize:15.0f];
        _feeLabel.text = @"费用: ¥-- / 余额: ¥--";
        _feeLabel.textColor = [UIColor grayColor];
        _feeLabel.textAlignment = NSTextAlignmentLeft;
        _feeLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_feeLabel];
    }
    return _feeLabel;
}

-(UICollectionViewLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 15.0f; // item 纵间距
        _layout.minimumInteritemSpacing = 10.0f; // item之间 行间距
    }
    return _layout;
}

-(UICollectionView *)selectCollectView
{
    if (!_selectCollectView) {
        CGFloat x = 0.0f;
        CGFloat y = _feeLabel.frame.origin.y + _feeLabel.frame.size.height + 10.0f;
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

-(NSArray *)data
{
    if (!_data) {
        _data = [[NSArray alloc] init];
    }
    return _data;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 每个item的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat FilterCellItemWidth = ([GeneralSize getMainScreenWidth] - 50.0f) / 4;
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
    return _data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChargeCell *cell = (ChargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:DurationCellIdentifier forIndexPath:indexPath];
    
    DurationModel *model = self.data[indexPath.row];
    cell.titleLabel.text = model.name;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSInteger i = 0; i < self.data.count;i++) {
        if (i == indexPath.item) {
            [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }else {
            [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
        }
    }
    DurationModel *model = _data[indexPath.row];
    CGFloat fee = [model.value floatValue] * _price / 100.0;
    
    _feeLabel.text = [NSString stringWithFormat:@"费用: ¥%.2f / 余额: ¥%.2f",fee,_account];
    
    if (fee > _account) {
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"账户余额不足" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
        UIAlertAction *rechargeAction = [UIAlertAction actionWithTitle:@"立即充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf payClickAction];
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:rechargeAction];
        [self presentViewController:alertVC animated:YES completion:NULL];
    }
}

#pragma mark - private method
-(void)getDeviceTemplate
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixDeviceTemplate];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"deviceSerialNum" : _KYDictionary[@"deviceSerialNum"], @"clientType" : @"IOS"};
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDic) {
        [CustomAlertView hide];
        
        NSString *code = [NSString stringWithFormat:@"%@",resultDic[@"code"]];
        NSString *msg = [NSString stringWithFormat:@"%@",resultDic[@"msg"]];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        weakSelf.price = [resultDic[@"data"] floatValue];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

// 获取账户余额
-(void)getUserAccount
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixUserInfo];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerDictionary = @{@"access_token" : accessToken};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
        
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
        double balance = [data[@"balance"] floatValue] / 100;
        weakSelf.account = balance;
        weakSelf.feeLabel.text = [NSString stringWithFormat:@"费用: ¥-- / 余额: ¥%.2f",balance];
        
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

#pragma mark - click action
// 开始充电
-(void)startChargeClick
{
    if ([[self.selectCollectView indexPathsForSelectedItems] count] == 0) {
        [CustomAlertView showWithWarnMessage:@"请选择充电时长"];
        return;
    }
    
    NSIndexPath *indexPath = [self.selectCollectView indexPathsForSelectedItems][0];
    DurationModel *model = _data[indexPath.row];
    NSInteger time = [model.value floatValue] * 60;
    NSString *Time = [NSString stringWithFormat:@"%ld",(long)time];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixStartCharge];
    NSString *accrssToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accrssToken};
    NSDictionary *bodyParam = @{@"childDeviceSerialNum" : _KYDictionary[@"childDeviceSerialNum"],
                                @"deviceSerialNum" : _KYDictionary[@"deviceSerialNum"],
                                @"batteryType" : _KYDictionary[@"batteryType"],
                                @"batteryVoltage" : _KYDictionary[@"batteryVoltage"],
                                @"time" : Time,
                                @"clientType" : @"IOS"};
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        NSLog(@"result - %@",result);
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

// 跳转充值界面
-(void)payClickAction
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    RechargeController *rechargeVC = [mineSB instantiateViewControllerWithIdentifier:@"RechargeController"];
    [self.navigationController pushViewController:rechargeVC animated:YES];
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
