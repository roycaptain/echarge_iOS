//
//  CitySwitchController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/1.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CitySwitchController.h"
#import "CitySwitchView.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "HistoryModel.h"

CGFloat const CitySearchViewHeight = 39.0f; // 搜索框的高度

@interface CitySwitchController ()<UITableViewDelegate,
                                    UITableViewDataSource,
                                    CitySwitchDelegate,
                                    AMapSearchDelegate,
                                    UISearchBarDelegate>

@property(nonatomic,strong)UITableView *cityTableView; //城市列表
@property(nonatomic,strong)UITableView *resultTableView; // 搜索结果列表
@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)CitySwitchView *locationView; // 定位城市
@property(nonatomic,strong)CitySwitchView *recentView; // 最近访问城市


@property(nonatomic,strong)NSDictionary *cityDictionary; // 全国城市列表
@property(nonatomic,strong)NSArray *keys; // 城市列表对应的索引
@property(nonatomic,strong)NSArray *recentCitys; // 最近访问的城市
@property(nonatomic,strong)NSArray *resultArray; // 搜索结果

@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,strong)AMapSearchAPI *searchAPI;
@property(nonatomic,strong)AMapGeocodeSearchRequest *geoRequest;

@end

@implementation CitySwitchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     获取参数列表数据
     */
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    self.cityDictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *keyArray = [self.cityDictionary allKeys];
    // 数组排序
    self.keys = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    // 最近访问城市
    self.recentCitys = [HistoryModel getCitySwitchHistoryInarchive];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"城市切换"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"000000"];
    
    [self searchAPI];
    [self geoRequest];
    
    [self searchBar];
    [self cityTableView];
    [self resultTableView];
    
    [self resultArray];
    
    // 城市view 定位城市和最近访问城市 高度都是 85.0f
    CGFloat cityViewsHeight = 85.0f;
    CGFloat tableHeaderHeight = (self.recentCitys.count > 0) ? cityViewsHeight * 2 : cityViewsHeight;
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], tableHeaderHeight)];
    tableHeader.backgroundColor = [UIColor redColor];
    _cityTableView.tableHeaderView = tableHeader;
    
    // 定位城市
    self.locationView = [[CitySwitchView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], cityViewsHeight)];
    self.locationView.delegate = self;
    [self.locationView setTitleLabelWithText:@"定位城市"];
    NSString *locationCity = [[UserInfoManager shareInstance] getUserLocationCity];
    if (locationCity) {
        [self.locationView setCityItemWithItemArray:@[locationCity]];
    }
    [self.locationView setLocationItem];
    [tableHeader addSubview:self.locationView];
    // 最近访问城市
    if (self.recentCitys.count > 0) {
        self.recentView = [[CitySwitchView alloc] initWithFrame:CGRectMake(0.0f, cityViewsHeight, [GeneralSize getMainScreenWidth], cityViewsHeight)];
        self.recentView.delegate = self;
        [self.recentView setTitleLabelWithText:@"定位城市"];
        [self.recentView setCityItemWithItemArray:self.recentCitys];
        [tableHeader addSubview:self.recentView];
    }
}

#pragma mark - lazy load
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = CitySearchViewHeight;
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _searchBar.placeholder = @"城市";
        _searchBar.delegate = self;
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}

-(UITableView *)cityTableView
{
    if (!_cityTableView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + CitySearchViewHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _cityTableView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
        _cityTableView.dataSource = self;
        _cityTableView.delegate = self;
        _cityTableView.sectionIndexColor = [UIColor colorWithHexString:@"#4CC1D7"]; // 索引字体的颜色
        [self.view addSubview:_cityTableView];
        
    }
    return _cityTableView;
}

-(UITableView *)resultTableView
{
    if (!_resultTableView) {
        CGFloat x = 0.0f;
        CGFloat y = _searchBar.frame.origin.y + _searchBar.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _resultTableView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
        _resultTableView.dataSource = self;
        _resultTableView.delegate = self;
        _resultTableView.hidden = YES;
        [self.view addSubview:_resultTableView];
    }
    return _resultTableView;
}

-(AMapLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.locationTimeout = 2;
        _locationManager.reGeocodeTimeout = 2;
        [_locationManager setDistanceFilter:kCLLocationAccuracyHundredMeters];
    }
    return _locationManager;
}

-(AMapSearchAPI *)searchAPI
{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc] init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

-(AMapGeocodeSearchRequest *)geoRequest
{
    if (!_geoRequest) {
        _geoRequest = [[AMapGeocodeSearchRequest alloc] init];
    }
    return _geoRequest;
}

-(NSArray *)recentCitys
{
    if (!_recentCitys) {
        _recentCitys = [[NSArray alloc] init];
    }
    return _recentCitys;
}

-(NSArray *)resultArray
{
    if (!_resultArray) {
        _resultArray = [[NSArray alloc] init];
    }
    return _resultArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _cityTableView) {
        return self.keys.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _cityTableView) {
        NSString *key = self.keys[section];
        NSArray *values = self.cityDictionary[key];
        return values.count;
    } else {
        return self.resultArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _cityTableView) {
        static NSString *CityCellIdentifier = @"CityCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CityCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CityCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSString *key = self.keys[indexPath.section];
        NSArray *values = self.cityDictionary[key];
        cell.textLabel.text = values[indexPath.row];
        
        return cell;
    } else if (tableView == _resultTableView) {
        static NSString *ResultCellIdentifier = @"ResultCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ResultCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = _resultArray[indexPath.row];
        
        return cell;
    } else {
        abort();
    }
}

// 索引数组
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _cityTableView) {
        return self.keys;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == _cityTableView) {
        return index - 1;
    }
    return 0;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _cityTableView) {
        return [NSString stringWithFormat:@"%@",self.keys[section]];
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _cityTableView) {
        return 27.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [CustomAlertView show];
    NSString *city;
    if (tableView == _cityTableView) {
        NSString *key = self.keys[indexPath.section];
        NSArray *values = self.cityDictionary[key];
        city = values[indexPath.row];
    } else {
        city = self.resultArray[indexPath.row];
    }
    _geoRequest.address = city;
    [_searchAPI AMapGeocodeSearch:_geoRequest];
}

#pragma mark - CitySwitchDelegate
// 点击定位按钮
-(void)citySwitchLocationWithName
{
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [self locationManager];
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        [CustomAlertView hide];
        if (error) {
            [CustomAlertView showWithFailureMessage:@"定位失败"];
        }
        
        NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        [[UserLocationManager shareInstance] setUserLocationWithLatitude:latitude withLongitude:longitude];
        [[UserInfoManager shareInstance] saveUserLocationWithLatitude:latitude withLongitude:longitude];
        
        if (regeocode) {
            NSString *city = [regeocode.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            [[UserInfoManager shareInstance] setUserLocationCity:city];
            [weakSelf.locationView setCityItemWithItemArray:@[city]];
        }
    }];
}

// 点击城市按钮
-(void)cityItemClickWithCity:(NSString *)city
{
    if ([[[UserInfoManager shareInstance] getUserLocationCity] isEqualToString:city]) {
        CGFloat latitude = [[[UserInfoManager shareInstance] getUserLocationWithLatitude] floatValue];
        CGFloat longitude = [[[UserInfoManager shareInstance] getUserLocationWithLongitude] floatValue];
        if (self.delegate && [self.delegate respondsToSelector:@selector(cityLocationWithCity:withLatitude:withLongitude:)]) {
            [self.delegate cityLocationWithCity:city withLatitude:latitude withLongitude:longitude];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } else {
        [CustomAlertView show];
        _geoRequest.address = city;
        [_searchAPI AMapGeocodeSearch:_geoRequest];
    }
}


#pragma mark - AMapSearchDelegate
-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    __weak typeof(self) weakSelf = self;
    if (response.geocodes.count == 0) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
        return;
    }
    [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [CustomAlertView hide];
        AMapGeocode *geocode = obj;
        NSString *city = [geocode.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        [HistoryModel saveCitySwitchHistoryWithCity:city withMaxCount:3];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cityLocationWithCity:withLatitude:withLongitude:)]) {
            [weakSelf.delegate cityLocationWithCity:city withLatitude:geocode.location.latitude withLongitude:geocode.location.longitude];
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        _resultTableView.hidden = YES;
    } else {
        _resultTableView.hidden = NO;
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchText];
    NSArray *cityArray = [self.cityDictionary allValues];
    NSMutableArray *citys = [[NSMutableArray alloc] init];
    for (NSArray *temp in cityArray) {
        [citys addObjectsFromArray:temp];
    }
    self.resultArray = [citys filteredArrayUsingPredicate:predicate];
    [_resultTableView reloadData];
}


//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
//    return view;
//}

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
