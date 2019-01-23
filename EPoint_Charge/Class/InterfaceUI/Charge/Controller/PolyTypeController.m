//
//  PolyTypeController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2019/1/14.
//  Copyright © 2019 dddgong. All rights reserved.
//

#import "PolyTypeController.h"
#import "ChargeCell.h"
#import "PolyTypeModel.h"
#import "DurationController.h"

NSString *const CollectCellIdentifier = @"CollectCellIdentifier";
NSString *const GunTypeIdentifier = @"GunTypeIdentifier";
NSString *const BatteryTypeIdentifier = @"BatteryTypeIdentifier";
NSString *const ColtageTypeIdentifier = @"ColtageTypeIdentifier";

@interface PolyTypeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *nextItem; // 下一步
@property(nonatomic,strong)UILabel *resultLabel; // 电压检测结果

@property(nonatomic,copy)NSArray *data;

@end

@implementation PolyTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self getChargeGunListRequest];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItemWithTarget:self action:@selector(backToRootClick)];
    [super setNavigationTitle:@"选择充电枪"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    [self layout];
    [self collectionView];
    
    [self.collectionView registerClass:[ChargeCell class] forCellWithReuseIdentifier:CollectCellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GunTypeIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BatteryTypeIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ColtageTypeIdentifier];
    [self nextItem];
}

#pragma mark - lazy load
-(UICollectionViewLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 10.0f;
        _layout.minimumLineSpacing = 10.0f;
    }
    return _layout;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y - TabBarHeight;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(UIButton *)nextItem
{
    if (!_nextItem) {
        CGFloat x = 0.0f;
        CGFloat height = 44.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        
        _nextItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextItem.frame = CGRectMake(x, y, width, height);
        [_nextItem setBackgroundColor:[UIColor colorWithHexString:@"#13BBC9"]];
        [_nextItem setTitle:@"下一步" forState:UIControlStateNormal];
        _nextItem.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_nextItem setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_nextItem addTarget:self action:@selector(nextClickAction) forControlEvents:UIControlEventTouchUpInside];
//        _nextItem.hidden = YES;
        [self.view addSubview:_nextItem];
    }
    return _nextItem;
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
    CGFloat FilterCellItemWidth = ([GeneralSize getMainScreenWidth] - 40) / 3;
    return CGSizeMake(FilterCellItemWidth, 44.0f);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

// 设置头部视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return CGSizeMake(0.0f, 50.0f);
    }
    return CGSizeMake(0.0f, 35.0f);
}

//设置尾部视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *rows = self.data[section];
    return rows.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChargeCell *cell = (ChargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectCellIdentifier forIndexPath:indexPath];
//    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    NSArray *rows = self.data[indexPath.section];
    if (indexPath.section == 0) {
        PolyTypeModel *model = rows[indexPath.row];
        cell.titleLabel.text = model.name;
    } else if (indexPath.section == 1) {
        PolyTypeModel *model = rows[indexPath.row];
        cell.titleLabel.text = model.name;
    } else if (indexPath.section == 2) {
        PolyTypeModel *model = rows[indexPath.row];
        cell.titleLabel.text = model.name;
    }
    
    return cell;
}

// 设置每组头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        UICollectionReusableView *gunTypeView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GunTypeIdentifier forIndexPath:indexPath];
//        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 1.0f)];
//        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
//        [gunTypeView addSubview:headLabel];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 12.0f, 100.0f, 15.0f)];
        headLabel.text = @"请选择充电枪";
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        headLabel.font = [UIFont systemFontOfSize:16.0f];
        headLabel.adjustsFontSizeToFitWidth = YES;
        [gunTypeView addSubview:headLabel];
        return gunTypeView;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 1) {
        UICollectionReusableView *batteryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BatteryTypeIdentifier forIndexPath:indexPath];
        
        UILabel *cutLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], 1.0f)];
        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [batteryView addSubview:cutLine];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 12.0f, 200.0f, 15.0f)];
        headLabel.text = @"请选择充电枪类型";
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        headLabel.font = [UIFont systemFontOfSize:16.0f];
        headLabel.adjustsFontSizeToFitWidth = YES;
        [batteryView addSubview:headLabel];
        
        return batteryView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 2) {
        UICollectionReusableView *voltageView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ColtageTypeIdentifier forIndexPath:indexPath];
        
        UILabel *cutLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], 1.0f)];
        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [voltageView addSubview:cutLine];
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 12.0f, 100.0f, 15.0f)];
        headLabel.text = @"请选择电压";
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        headLabel.font = [UIFont systemFontOfSize:16.0f];
        headLabel.adjustsFontSizeToFitWidth = YES;
        [voltageView addSubview:headLabel];
        if (!_resultLabel) {
            _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 30.0f, 200.0f, 15.0f)];
            _resultLabel.text = @"(待检测)";
            _resultLabel.textAlignment = NSTextAlignmentLeft;
            _resultLabel.textColor = [UIColor grayColor];
            _resultLabel.font = [UIFont systemFontOfSize:15.0f];
            _resultLabel.adjustsFontSizeToFitWidth = YES;
            [voltageView addSubview:_resultLabel];
        }
        return voltageView;
        
    } else {
        abort();
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (NSInteger i = 0; i < [[self.data objectAtIndex:indexPath.section] count];i++) {
        if (i == indexPath.item) {
            [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        }else {
            [collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
        }
    }
    if (indexPath.section == 0) { // 选择充电枪后进行电压检测
        PolyTypeModel *model = _data[indexPath.section][indexPath.row];
        [self postDeviceBatteryTest:model.value];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果点击了当前已经选中的cell  忽略她~
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

#pragma mark - click action
-(void)backToRootClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)nextClickAction
{
    NSArray *selects = [_collectionView indexPathsForSelectedItems];
    if (selects.count < 3) {
        [CustomAlertView showWithWarnMessage:@"请选择三种类型"];
    }
    
    NSIndexPath *gunPath = selects[0];
    PolyTypeModel *gunModel = _data[gunPath.section][gunPath.row];
    NSString *childDeviceSerialNum = gunModel.value;
    NSIndexPath *batteryPath = selects[1];
    PolyTypeModel *batteryModel = _data[batteryPath.section][batteryPath.row];
    NSString *batteryType = batteryModel.value;
    NSIndexPath *voltagePath = selects[2];
    PolyTypeModel *voltageModel = _data[voltagePath.section][voltagePath.row];
    NSString *batteryVoltage = voltageModel.value;
    
    NSDictionary *dictionary = @{@"deviceSerialNum" : self.deviceSerialNum,
                                 @"childDeviceSerialNum" : childDeviceSerialNum,
                                 @"batteryType" : batteryType,
                                 @"batteryVoltage" : batteryVoltage
                                 };
    
    UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
    DurationController *selectVC = [chargingSB instantiateViewControllerWithIdentifier:@"DurationController"];
    selectVC.type = self.type;
    selectVC.KYDictionary = dictionary;
    [self.navigationController pushViewController:selectVC animated:YES];
}

#pragma mark - private method
// 获取充电枪列表
-(void)getChargeGunListRequest
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
        NSMutableArray *mutableData = [[NSMutableArray alloc] init];
        
        NSMutableArray *gunMutableArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in data) {
            PolyTypeModel *model = [PolyTypeModel modelWithDictionary:dictionary];
            [gunMutableArr addObject:model];
        }
        NSArray *batterys = @[@{@"deviceName" : @"铅酸",@"deviceSerialNum" : @"1"},
                              @{@"deviceName" : @"锂电",@"deviceSerialNum" : @"2"}];
        NSMutableArray *batteryMutable = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in batterys) {
            PolyTypeModel *model = [PolyTypeModel modelWithDictionary:dictionary];
            [batteryMutable addObject:model];
        }
        
        NSArray *voltages = @[@{@"deviceName" : @"36V",@"deviceSerialNum" : @"36"},
                              @{@"deviceName" : @"48V",@"deviceSerialNum" : @"48"},
                              @{@"deviceName" : @"60V",@"deviceSerialNum" : @"60"},
                              @{@"deviceName" : @"72V",@"deviceSerialNum" : @"72"}];
        NSMutableArray *voltageMutable = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in voltages) {
            PolyTypeModel *model = [PolyTypeModel modelWithDictionary:dictionary];
            [voltageMutable addObject:model];
        }
        [mutableData addObject:[gunMutableArr mutableCopy]];
        [mutableData addObject:[batteryMutable mutableCopy]];
        [mutableData addObject:[voltageMutable mutableCopy]];
        weakSelf.data = [mutableData mutableCopy];
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

-(void)postDeviceBatteryTest:(NSString *)childDeviceSerialNum
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixDeviceBatteryTest];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"deviceSerialNum" : self.deviceSerialNum, @"childDeviceSerialNum" : childDeviceSerialNum, @"clientType" : @"IOS"};
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDic) {
        [CustomAlertView hide];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"msg"];
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"(%@)",msg];
        if ([code integerValue] != 200) {
//            weakSelf.nextItem.hidden = YES;
            return ;
        }
//        weakSelf.nextItem.enabled = NO;
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"(%@ %@)",msg,resultDic[@"data"]];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        weakSelf.resultLabel.text = @"(检测超时,请重试!)";
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
