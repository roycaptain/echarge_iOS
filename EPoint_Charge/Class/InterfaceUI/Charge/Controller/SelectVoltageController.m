//
//  SelectVoltageController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/12/28.
//  Copyright © 2018 dddgong. All rights reserved.
//

#import "SelectVoltageController.h"
#import "VoltageModel.h"
#import "ChargeCell.h"
#import "ChargingController.h"

NSString *const VoltageCellIdentifier = @"VoltageCellIdentifier";

@interface SelectVoltageController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *selectCollectView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UIButton *startChargeItem; // 开始充电按钮

@property(nonatomic,strong)NSArray *data; // 数据

@end

@implementation SelectVoltageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    NSArray *arr = @[@{@"name" : @"12V", @"value" : @"12"},
                     @{@"name" : @"24V", @"value" : @"24"}];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in arr) {
        VoltageModel *model = [VoltageModel modelWithDictionary:dictionary];
        [mutableArray addObject:model];
    }
    self.data = [mutableArray mutableCopy];
    [_selectCollectView reloadData];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItemWithTarget:self action:@selector(backToRootClick)];
    [super setNavigationTitle:@"选择电压"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    [self startChargeItem];
    [self layout];
    [self selectCollectView];
    [_selectCollectView registerClass:[ChargeCell class] forCellWithReuseIdentifier:VoltageCellIdentifier];
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
    return self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChargeCell *cell = (ChargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:VoltageCellIdentifier forIndexPath:indexPath];
    
    VoltageModel *model = self.data[indexPath.row];
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
}

#pragma mark - click action
-(void)backToRootClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 开始充电
-(void)startChargeClick
{
    if ([[self.selectCollectView indexPathsForSelectedItems] count] == 0) {
        [CustomAlertView showWithWarnMessage:@"请选择充电枪"];
        return;
    }
    
    NSIndexPath *indexPath = [self.selectCollectView indexPathsForSelectedItems][0];
    VoltageModel *model = self.data[indexPath.row];
    NSString *childDeviceSerialNum = [NSString stringWithFormat:@"%@",self.childDeviceSerialNum];
    NSString *deviceSerialNum = [NSString stringWithFormat:@"%@",self.deviceSerialNum];
    NSString *batteryVoltage = [NSString stringWithFormat:@"%@",model.value];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixStartCharge];
    NSString *accrssToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accrssToken};
    
    NSDictionary *bodyParam = @{@"deviceSerialNum" : deviceSerialNum,
                                @"childDeviceSerialNum" : childDeviceSerialNum,
                                @"batteryVoltage" : batteryVoltage,
                                @"clientType" : @"IOS"
                                };

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
