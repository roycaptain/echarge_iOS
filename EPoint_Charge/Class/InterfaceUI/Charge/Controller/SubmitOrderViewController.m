//
//  SubmitOrderViewController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/8.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "PaymentView.h"

@interface SubmitOrderViewController ()<PaymentViewDelegate>

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UILabel *paySum; // 支付金额
@property(nonatomic,strong)UILabel *rmbLabel; // 人民币标识
@property(nonatomic,strong)UILabel *sumLabel; // 金额
@property(nonatomic,strong)UILabel *payTypeLabel; // 请选择支付方式
@property(nonatomic,strong)PaymentView *paymentView; // 支付方式
@property(nonatomic,strong)UIButton *historyItem; // 历史交易订单
@property(nonatomic,strong)UIButton *payItem; //立即支付

@end

@implementation SubmitOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"提交订单"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self topView];
    [self paySum];
    [self sumLabel];
    [self rmbLabel];
    [self payTypeLabel];
    [self paymentView];
    [self historyItem];
    [self payItem];
}

#pragma mark - lazy load
-(UIView *)topView
{
    if (!_topView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 160.0f;
        
        _topView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self.view addSubview:_topView];
    }
    return _topView;
}

-(UILabel *)paySum
{
    if (!_paySum) {
        CGFloat width = 71.0f;
        CGFloat height = 17.0f;
        CGFloat x = (_topView.frame.size.width - width) / 2;
        CGFloat y = 35.0f;
        
        _paySum = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _paySum.text = @"支付金额";
        _paySum.textColor = [UIColor colorWithHexString:@"#666666"];
        _paySum.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        _paySum.textAlignment = NSTextAlignmentCenter;
        _paySum.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:_paySum];
    }
    return _paySum;
}

-(UILabel *)sumLabel
{
    if (!_sumLabel) {
        CGFloat x = _paySum.frame.origin.x;
        CGFloat y = _paySum.frame.origin.y + 19.0f + _paySum.frame.size.height;
        CGFloat width = 150.0f;
        CGFloat height = 35.0f;
        
        _sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _sumLabel.textAlignment = NSTextAlignmentLeft;
        _sumLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _sumLabel.font = [UIFont fontWithName:@"PingFang SC" size:46.0f];
        _sumLabel.text = @"100";
        _sumLabel.adjustsFontSizeToFitWidth = YES;
        [_topView addSubview:_sumLabel];
    }
    return _sumLabel;
}

-(UILabel *)rmbLabel
{
    if (!_rmbLabel) {
        CGFloat width = 20.0f;
        CGFloat height = 18.0f;
        CGFloat x = _sumLabel.frame.origin.x - 20.0f;
        CGFloat y = _sumLabel.frame.origin.y + _sumLabel.frame.size.height - height;
        
        _rmbLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _rmbLabel.textAlignment = NSTextAlignmentLeft;
        _rmbLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _rmbLabel.font = [UIFont fontWithName:@"PingFang SC" size:18.0f];
        _rmbLabel.text = @"￥";
        [_topView addSubview:_rmbLabel];
    }
    return _rmbLabel;
}

-(UILabel *)payTypeLabel
{
    if (!_payTypeLabel) {
        CGFloat x = 19.0f;
        CGFloat y = _topView.frame.origin.y + _topView.frame.size.height + 10.0f;
        CGFloat width = 120.0f;
        CGFloat height = 16.0f;
        
        _payTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _payTypeLabel.text = @"请选择支付方式";
        _payTypeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _payTypeLabel.font = [UIFont systemFontOfSize:12.0f];
        _payTypeLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_payTypeLabel];
    }
    return _payTypeLabel;
}

-(PaymentView *)paymentView
{
    if (!_paymentView) {
        CGFloat x = 0.0f;
        CGFloat y = _payTypeLabel.frame.origin.y + _payTypeLabel.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 91.0f;
        
        _paymentView = [[PaymentView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _paymentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _paymentView.delegate = self;
        [self.view addSubview:_paymentView];
    }
    return _paymentView;
}

-(UIButton *)historyItem
{
    if (!_historyItem) {
        CGFloat width = 100.0f;
        CGFloat height = 12.0f;
        CGFloat x = [GeneralSize getMainScreenWidth] - width - 12.0f;
        CGFloat y = _paymentView.frame.origin.y + _paymentView.frame.size.height + 15.0f;
        
        _historyItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyItem.frame = CGRectMake(x, y, width, height);
        [_historyItem setTitle:@"查看历史交易订单" forState:UIControlStateNormal];
        _historyItem.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [_historyItem setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_historyItem addTarget:self action:@selector(historyOrderClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_historyItem];
    }
    return _historyItem;
}

-(UIButton *)payItem
{
    if (!_payItem) {
        CGFloat x = 34.0f;
        CGFloat height = 44.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height - TabBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        
        _payItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _payItem.frame = CGRectMake(x, y, width, height);
        [_payItem setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_payItem setTitle:@"立即支付" forState:UIControlStateNormal];
        _payItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_payItem setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_payItem addTarget:self action:@selector(payItemClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_payItem];
    }
    return _payItem;
}

#pragma mark - PaymentViewDelegate
-(void)clickWithPaymentItem:(PaymentType)payType
{
    NSLog(@" 支付方式 - %lu ",(unsigned long)payType);
}

#pragma mark - click
-(void)historyOrderClick
{
    NSLog(@"查看历史交易订单");
}

-(void)payItemClick
{
    NSLog(@"立即支付");
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
