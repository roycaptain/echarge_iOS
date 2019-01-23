//
//  ElectricDetailController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/13.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ElectricDetailController.h"
#import "ElectricDetailCell.h"
#import "ElectricDetailModel.h"

#define ContentWidth [GeneralSize getMainScreenWidth] / 5

CGFloat const TableHeaderViewHeight = 52.0f;

@interface ElectricDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *electricTableView;
@property(nonatomic,strong)UIView *tableHeaderView;
@property(nonatomic,strong)UIView *tableFooterView;

@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation ElectricDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    if (self.templateList.count == 0) {
        [CustomAlertView showWithWarnMessage:@"暂无数据"];
        return;
    }
    
    for (NSInteger index = 0; index < self.templateList.count; index++) {
        ElectricDetailModel *model = [ElectricDetailModel modelWithDictionary:self.templateList withIndex:index];
        [_data addObject:model];
    }
    [_electricTableView reloadData];
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
    [super setNavigationTitle:@"电价详情"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#000000"];
    
    [self electricTableView];
    [self tableHeaderView];
    [self tableFooterView];
    [self data];
}

#pragma mark - lazy load
-(UITableView *)electricTableView
{
    if (!_electricTableView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _electricTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStyleGrouped];
        _electricTableView.delegate = self;
        _electricTableView.dataSource = self;
        [self.view addSubview:_electricTableView];
    }
    return _electricTableView;
}

-(UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], TableHeaderViewHeight)];
        // 时段
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ContentWidth * 2, TableHeaderViewHeight)];
        timeLabel.text = @"时段";
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        timeLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_tableHeaderView addSubview:timeLabel];
        // 充电单价
        UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(ContentWidth * 2, 0.0f, ContentWidth, TableHeaderViewHeight)];
        unitLabel.text = @"充电单价 \n (元/度)";
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        unitLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        unitLabel.numberOfLines = 0;
        [_tableHeaderView addSubview:unitLabel];
        // 服务费
        UILabel *serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ContentWidth * 3, 0.0f, ContentWidth, TableHeaderViewHeight)];
        serviceLabel.text = @"服务费 \n (元/度)";
        serviceLabel.textAlignment = NSTextAlignmentCenter;
        serviceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        serviceLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        serviceLabel.numberOfLines = 0;
        [_tableHeaderView addSubview:serviceLabel];
        // 实际费用
        UILabel *actualLabel = [[UILabel alloc] initWithFrame:CGRectMake(ContentWidth * 4, 0.0f, ContentWidth, TableHeaderViewHeight)];
        actualLabel.text = @"实际费用 \n (元/度)";
        actualLabel.textAlignment = NSTextAlignmentCenter;
        actualLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13.0f];
        actualLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        actualLabel.numberOfLines = 0;
        [_tableHeaderView addSubview:actualLabel];
        _electricTableView.tableHeaderView = _tableHeaderView;
    }
    return _tableHeaderView;
}

-(UIView *)tableFooterView
{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], TableHeaderViewHeight)];
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], TableHeaderViewHeight)];
        tipLabel.text = @"充电费用仅供参考，请以充电桩上的费用为准";
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        tipLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:11.0f];
        [_tableFooterView addSubview:tipLabel];
        _electricTableView.tableFooterView = _tableFooterView;
    }
    return _tableFooterView;
}

-(NSMutableArray *)data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ElectricCellIdentifier = @"ElectricCellIdentifier";
    ElectricDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ElectricCellIdentifier];
    if (cell == nil) {
        cell = [[ElectricDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ElectricCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ElectricDetailModel *model = _data[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
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
