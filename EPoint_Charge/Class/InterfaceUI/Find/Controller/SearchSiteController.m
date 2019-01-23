//
//  SearchSiteController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/10.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SearchSiteController.h"
#import "SiteModel.h"
#import "HistoryModel.h"
#import "SiteHistoryCell.h"

NSString *const SiteHistoryCellIdentifier = @"SiteHistoryCellIdentifier";
NSString *const SiteHeaderIdentifier = @"SiteHeaderIdentifier";

@interface SearchSiteController ()<AMapSearchDelegate,
                                    UITextFieldDelegate,
                                    UITableViewDelegate,
                                    UITableViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UIView *searchBar;
@property(nonatomic,strong)UITextField *searchField;
@property(nonatomic,strong)UIImageView *searchIcon;
@property(nonatomic,strong)UITableView *siteTableView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *historyCollectionView;

@property(nonatomic,strong)NSMutableArray *siteArray; // 搜索时地点数据
@property(nonatomic,strong)NSMutableArray *historySite; // 搜索历史

@property(nonatomic,strong)AMapSearchAPI *searchAPI;
@property(nonatomic,strong)AMapPOIKeywordsSearchRequest *poiRequest;

@end

@implementation SearchSiteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];

    NSArray *historys = [HistoryModel getSrearchSiteHistoryInArchive];
    for (NSDictionary *dict in historys) {
        SiteModel *model = [SiteModel modelWithDictionary:dict];
        [self.historySite addObject:model];
    }
    [_historyCollectionView reloadData];
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
    [super setNavigationRightButtonItemWithTitle:@"搜索" withTarget:self withAction:@selector(searchClick)];
    
    [self siteArray];
    [self historySite];
    
    [self searchAPI];
    [self poiRequest];
    
    [self searchBar];
    [self searchIcon];
    [self searchField];
    [self layout];
    [self historyCollectionView];
    
    [self siteTableView];
    
    [_historyCollectionView registerClass:[SiteHistoryCell class] forCellWithReuseIdentifier:SiteHistoryCellIdentifier];
    [_historyCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SiteHeaderIdentifier];
}

#pragma mark - lazy load
// 搜索框
-(UIView *)searchBar
{
    if (!_searchBar) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - 114.0f;
        CGFloat height = 34.0f;
        
        _searchBar = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _searchBar.layer.cornerRadius = 17.0f;
        _searchBar.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        self.navigationItem.titleView = _searchBar;
    }
    return _searchBar;
}

-(UIImageView *)searchIcon
{
    if (!_searchIcon) {
        CGFloat width = 18.0f;
        CGFloat x = 10.0f;
        CGFloat y = 9.0f;
        
        _searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [_searchIcon setImage:[UIImage imageNamed:@"search_magnifier"]];
        [_searchBar addSubview:_searchIcon];
    }
    return _searchIcon;
}

-(UITextField *)searchField
{
    if (!_searchField) {
        CGFloat x = _searchIcon.frame.origin.x + _searchIcon.frame.size.width + 9.0f;
        CGFloat y = 0.0f;
        CGFloat width = 260.0f;
        CGFloat height = 34.0f;
        
        _searchField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _searchField.placeholder = @"请输入要查找的地名";
        _searchField.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
        _searchField.delegate = self;
        _searchField.returnKeyType = UIReturnKeyDone;
        [_searchBar addSubview:_searchField];
    }
    return _searchField;
}

// 搜索结果列表
-(UITableView *)siteTableView
{
    if (!_siteTableView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _siteTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _siteTableView.delegate = self;
        _siteTableView.dataSource = self;
        _siteTableView.hidden = YES;
        // 补全分割线
        if ([_siteTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _siteTableView.separatorInset = UIEdgeInsetsZero;
        }
        [self.view addSubview:_siteTableView];
    }
    return _siteTableView;
}

-(AMapSearchAPI *)searchAPI
{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc] init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

-(AMapPOIKeywordsSearchRequest *)poiRequest
{
    if (!_poiRequest) {
        _poiRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
        _poiRequest.requireExtension = YES;
        _poiRequest.cityLimit = YES;
        _poiRequest.requireSubPOIs = YES;
    }
    return _poiRequest;
}

// 搜索结果数据
-(NSMutableArray *)siteArray
{
    if (!_siteArray) {
        _siteArray = [[NSMutableArray alloc] init];
    }
    return _siteArray;
}

// 搜索历史数据
-(NSMutableArray *)historySite
{
    if (!_historySite) {
        _historySite = [[NSMutableArray alloc] init];
    }
    return _historySite;
}

// 搜索历史
-(UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 15.0f;
        _layout.minimumInteritemSpacing = 10.0f;
        _layout.headerReferenceSize = CGSizeMake([GeneralSize getMainScreenWidth], 40.0f);
    }
    return _layout;
}

-(UICollectionView *)historyCollectionView
{
    if (!_historyCollectionView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _historyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:_layout];
        _historyCollectionView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _historyCollectionView.dataSource = self;
        _historyCollectionView.delegate = self;
        [self.view addSubview:_historyCollectionView];
    }
    return _historyCollectionView;
}

#pragma mark - click
// 搜索按钮
-(void)searchClick
{
    [CustomAlertView show];
    [_siteArray removeAllObjects];
    [_searchField resignFirstResponder];
    NSString *site = _searchField.text;
    _poiRequest.keywords = site;
    [_searchAPI AMapPOIKeywordsSearch:_poiRequest];
}

// 清除搜索历史
-(void)clearClick
{
    [self.historySite removeAllObjects];
    [self.historyCollectionView reloadData];
    [HistoryModel clearUpSearchSiteHistory];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _siteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SiteCellIdentifier = @"SiteCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SiteCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SiteCellIdentifier];
    }
    
    SiteModel *model = _siteArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"place"];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detailTitle;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiteModel *model = _siteArray[indexPath.row];
    CGFloat latitude = model.latitude;
    CGFloat longitude = model.longitude;
    
    [HistoryModel saveSearchSiteHistoryWithSiteModel:model withMaxCount:10];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationMapCenterSiteWithLatitude:withLongitude:)]) {
        [self.delegate locationMapCenterSiteWithLatitude:latitude withLongitude:longitude];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _siteTableView.hidden = NO;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - AMapSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:@"检索失败"];
        return;
    }
    NSArray *pois = response.pois;
    for (AMapPOI *poi in pois) {
        SiteModel *model = [SiteModel modelWithAMapPOI:poi];
        [_siteArray addObject:model];
    }
    [CustomAlertView hide];
    [_siteTableView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 每个item的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteModel *model = _historySite[indexPath.row];
    CGFloat width = model.itemWidth + 26.0f;
    CGFloat height = model.itemHeight;
    return CGSizeMake(width, height);
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
    return _historySite.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteHistoryCell *cell = (SiteHistoryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:SiteHistoryCellIdentifier forIndexPath:indexPath];
    
    SiteModel *model = self.historySite[indexPath.row];
    cell.titleLabel.text = model.title;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SiteHeaderIdentifier forIndexPath:indexPath];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], 40.0f)];
    [reusableView addSubview:headerView];
    
    UIImageView *searchView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0f, 23.0f, 14.0f, 14.0f)];
    searchView.image = [UIImage imageNamed:@"search_magnifier"];
    [headerView addSubview:searchView];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(searchView.frame.origin.x + searchView.frame.size.width + 6.0f, 24.0f, 50.0f, 12.0f)];
    searchLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    searchLabel.textAlignment = NSTextAlignmentLeft;
    searchLabel.text = @"历史搜索";
    searchLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
    searchLabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:searchLabel];
    
    UIButton *clearItem = [UIButton buttonWithType:UIButtonTypeCustom];
    clearItem.frame = CGRectMake([GeneralSize getMainScreenWidth] - 30.0f, 23.0f, 14.0f, 14.0f);
    [clearItem setImage:[UIImage imageNamed:@"clear_icon"] forState:UIControlStateNormal];
    [clearItem addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:clearItem];
    return reusableView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SiteModel *model = _historySite[indexPath.row];
    CGFloat latitude = model.latitude;
    CGFloat longitude = model.longitude;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationMapCenterSiteWithLatitude:withLongitude:)]) {
        [self.delegate locationMapCenterSiteWithLatitude:latitude withLongitude:longitude];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
