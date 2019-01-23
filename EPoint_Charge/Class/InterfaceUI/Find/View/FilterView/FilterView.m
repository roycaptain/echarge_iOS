//
//  FilterView.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/29.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FilterView.h"
#import "FilterCell.h"

NSString *const FilterCellIdentifier = @"FilterCellIdentifier";
NSString *const StationTypeHeaderIdentifier = @"StationTypeHeaderIdentifier";
NSString *const DisatnceIdentifier = @"DisatnceIdentifier";
NSString *const CarrierIdentifier = @"CarrierIdentifier";
NSString *const FilterFooterIdentifier = @"FilterFooterIdentifier";
CGFloat const FilterLeftSpace = 46.0f;
CGFloat const FilterCellItemHeight = 44.0f;

@implementation FilterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isUse = YES;
        [self data];
        [self initUI];
    }
    return self;
}

#pragma mark - initUI
-(void)initUI
{
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    
    // 设置 UICollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10.0f; // item之间 行间距
    layout.minimumLineSpacing = 10.0f; // item 纵间距
    
    CGFloat x = FilterLeftSpace;
    CGFloat y = [GeneralSize getStatusBarHeight];
    CGFloat width = [GeneralSize getMainScreenWidth] - FilterLeftSpace;
    CGFloat height = [GeneralSize getMainScreenHeight] - [GeneralSize getStatusBarHeight] - 49.0f;
    
    self.filterCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:layout];
    self.filterCollectionView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];//
    self.filterCollectionView.delegate = self;
    self.filterCollectionView.dataSource = self;
    self.filterCollectionView.contentInset = UIEdgeInsetsMake(43.0f, 0.0f, 49.0f, 0.0f);
    self.filterCollectionView.allowsMultipleSelection = YES;
    [self addSubview:self.filterCollectionView];
    
    // filterCollectionView 的头部视图
    CGFloat headerX = 0.0f;
    CGFloat headerY = -43.0f;
    CGFloat headerWidth = [GeneralSize getMainScreenWidth];
    CGFloat headerHeight = 43.0f;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(headerX, headerY, headerWidth, headerHeight)];
    [self.filterCollectionView addSubview:headerView];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 17.0f, 34.0f, 17.0f)];
    headerLabel.text = @"筛选";
    headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
    headerLabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:headerLabel];
    
    [self.filterCollectionView registerClass:[FilterCell class] forCellWithReuseIdentifier:FilterCellIdentifier];
    [self.filterCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:StationTypeHeaderIdentifier];
    [self.filterCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DisatnceIdentifier];
    [self.filterCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CarrierIdentifier];
    [self.filterCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FilterFooterIdentifier];
    
    CGFloat ButtonWidth = ([GeneralSize getMainScreenWidth] - FilterLeftSpace) / 2;
    CGFloat ButtonHeight = 49.0f;
    
    // 重置按钮
    self.resetItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resetItem.frame = CGRectMake(FilterLeftSpace, [GeneralSize getMainScreenHeight] - ButtonHeight, ButtonWidth, ButtonHeight);
    self.resetItem.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.resetItem setTitle:@"重置" forState:UIControlStateNormal];
    [self.resetItem setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.resetItem addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.resetItem];
    
    // 确认按钮
    self.confirmItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmItem.frame = CGRectMake([GeneralSize getMainScreenWidth] - ButtonWidth, [GeneralSize getMainScreenHeight] - ButtonHeight, ButtonWidth, ButtonHeight);
    self.confirmItem.backgroundColor = [UIColor colorWithHexString:@"#31CEC0"];
    [self.confirmItem setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmItem setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    [self.confirmItem addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.confirmItem];

}

#pragma mark - load -lazy

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
    CGFloat FilterCellItemWidth = ([GeneralSize getMainScreenWidth] - FilterLeftSpace - 40.0f) / 3;
    return CGSizeMake(FilterCellItemWidth, FilterCellItemHeight);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

// 设置头部视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0.0f, 35.0f);
}

//设置尾部视图高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return CGSizeMake(0.0f, 47.0f);
    }
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
    FilterCell *cell = (FilterCell *)[collectionView dequeueReusableCellWithReuseIdentifier:FilterCellIdentifier forIndexPath:indexPath];
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    NSArray *rows = self.data[indexPath.section];
    if (indexPath.section == 0) {
        NSDictionary *dictionary = rows[indexPath.row];
        cell.titleLabel.text = dictionary[@"stationName"];
    } else if (indexPath.section == 1) {
        NSDictionary *dictionary = rows[indexPath.row];
        cell.titleLabel.text = dictionary[@"title"];
    } else if (indexPath.section == 2) {
        NSDictionary *dictionary = rows[indexPath.row];
        cell.titleLabel.text = dictionary[@"companyName"];
    }

    return cell;
}

// 设置每组头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 0) {
        UICollectionReusableView *stationTypeView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:StationTypeHeaderIdentifier forIndexPath:indexPath];
        UILabel *cutLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth] - FilterLeftSpace, 1.0f)];
        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [stationTypeView addSubview:cutLine];
        UILabel *stationLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 12.0f, 63.0f, 15.0f)];
        stationLabel.text = @"站点类型";
        stationLabel.textAlignment = NSTextAlignmentLeft;
        stationLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        stationLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        stationLabel.adjustsFontSizeToFitWidth = YES;
        [stationTypeView addSubview:stationLabel];
        return stationTypeView;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 1) {
        UICollectionReusableView *distanceView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DisatnceIdentifier forIndexPath:indexPath];
        
        UILabel *cutLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth] - FilterLeftSpace, 1.0f)];
        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [distanceView addSubview:cutLine];
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 12.0f, 63.0f, 15.0f)];
        distanceLabel.text = @"距离范围";
        distanceLabel.textAlignment = NSTextAlignmentLeft;
        distanceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        distanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        distanceLabel.adjustsFontSizeToFitWidth = YES;
        [distanceView addSubview:distanceLabel];
        
        return distanceView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section == 2) {
        UICollectionReusableView *carrierView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CarrierIdentifier forIndexPath:indexPath];
        
        UILabel *cutLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth] - FilterLeftSpace, 1.0f)];
        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [carrierView addSubview:cutLine];
        UILabel *carrierLabel = [[UILabel alloc] initWithFrame:CGRectMake(18.0f, 12.0f, 63.0f, 15.0f)];
        carrierLabel.text = @"运营商";
        carrierLabel.textAlignment = NSTextAlignmentLeft;
        carrierLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        carrierLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        carrierLabel.adjustsFontSizeToFitWidth = YES;
        [carrierView addSubview:carrierLabel];
        
        return carrierView;
        
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section == 2) {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FilterFooterIdentifier forIndexPath:indexPath];
        UILabel *cutLine = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth] - FilterLeftSpace, 1.0f)];
        cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [footerView addSubview:cutLine];
        UILabel *stationLabel = [[UILabel alloc] initWithFrame:CGRectMake(19.0f, 14.0f, 110.0f, 15.0f)];
        stationLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        stationLabel.text = @"只显示空闲电桩";
        stationLabel.textAlignment = NSTextAlignmentLeft;
        stationLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        stationLabel.adjustsFontSizeToFitWidth = YES;
        [footerView addSubview:stationLabel];
        
        CGFloat x = [GeneralSize getMainScreenWidth] - FilterLeftSpace - 51.0f - 15.0f;
        UISwitch *showSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(x, 6.0f, 51.0f, 31.0f)];
        showSwitch.on = YES;
        showSwitch.onTintColor = [UIColor colorWithHexString:@"#32CFC1"];
        [showSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [footerView addSubview:showSwitch];
        
        return footerView;
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
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果点击了当前已经选中的cell  忽略她~
    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

#pragma mark - private method
-(void)presentFilterView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.frame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    }];
}

-(void)dismissFilterView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.frame = CGRectMake([GeneralSize getMainScreenWidth], 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissFilterView];
}


#pragma mark - click
-(void)resetClick
{
    [self.filterCollectionView reloadData];
}

-(void)switchAction:(UISwitch *)showSwitch
{
    self.isUse = (showSwitch.on == YES) ? YES : NO;
}

-(void)confirmClick
{
    NSDictionary *dictionary = [self getCollectViewSelectedItems];
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmClickWithBodyParam:)]) {
        [self.delegate confirmClickWithBodyParam:dictionary];
    }
    [self dismissFilterView];
}

-(NSDictionary *)getCollectViewSelectedItems
{
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    NSString *latitude = [[UserLocationManager shareInstance] getUserLocationWithLatitude];
    NSString *longitude = [[UserLocationManager shareInstance] getUserLocationWithLongitude];
    NSNumber *isUser = [NSNumber numberWithBool:self.isUse];
    
    [mutableDictionary setValue:latitude forKey:@"latitude"];
    [mutableDictionary setValue:longitude forKey:@"longitude"];
    [mutableDictionary setValue:isUser forKey:@"isUse"];
    
    for (NSIndexPath *indexPath in [self.filterCollectionView indexPathsForSelectedItems]) {
        // 站点类型
        if (indexPath.section == 0 && indexPath.row != 0) {
            NSArray *stations = self.data[indexPath.section];
            NSDictionary *stationDictionary = stations[indexPath.row];
            NSInteger station = [stationDictionary[@"stationType"] integerValue];
            NSNumber *stationType = [NSNumber numberWithInteger:station];
            [mutableDictionary setValue:stationType forKey:@"stationType"];
        }
        // 距离范围
        if (indexPath.section == 1 && indexPath.row != 0) {
            NSArray *distances = self.data[indexPath.section];
            NSDictionary *distanceDic = distances[indexPath.row];
            NSString *startDistance = distanceDic[@"startDistance"];
            NSString *endDistance = distanceDic[@"endDistance"];
            [mutableDictionary setValue:startDistance forKey:@"startDistance"];
            [mutableDictionary setValue:endDistance forKey:@"endDistance"];
        }
        // 运营商
        if (indexPath.section == 2 && indexPath.row != 0) {
            NSArray *companys = self.data[indexPath.section];
            NSDictionary *companyDic = companys[indexPath.row];
            NSInteger company = [companyDic[@"companyId"] integerValue];
            NSNumber *companyId = [NSNumber numberWithInteger:company];
            [mutableDictionary setValue:companyId forKey:@"companyId"];
        }
    }
    NSDictionary *result = [mutableDictionary mutableCopy];
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
