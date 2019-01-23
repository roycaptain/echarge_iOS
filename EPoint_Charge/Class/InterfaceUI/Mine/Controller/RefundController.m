//
//  RefundController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "RefundController.h"
#import "RefundView.h"
#import "PaymentView.h"

@interface RefundController ()<PaymentViewDelegate>

@property(nonatomic,strong)RefundView *refundView;
@property(nonatomic,strong)UILabel *grayLabel;
@property(nonatomic,strong)UILabel *refundLabel;
@property(nonatomic,strong)PaymentView *paymentView;
@property(nonatomic,strong)UIButton *submit;

@property(nonatomic,assign)PaymentType payType; // 退款方式

@end

@implementation RefundController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark -lazy load
-(RefundView *)refundView
{
    if (!_refundView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 132.0f;
        
        _refundView = [[RefundView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _refundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_refundView];
    }
    return _refundView;
}

-(UILabel *)grayLabel
{
    if (!_grayLabel) {
        CGFloat x = 0.0;
        CGFloat y = _refundView.frame.origin.y + _refundView.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 7.0f;
        
        _grayLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _grayLabel.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
        [self.view addSubview:_grayLabel];
    }
    return _grayLabel;
}

-(UILabel *)refundLabel
{
    if (!_refundLabel) {
        CGFloat x = 14.0f;
        CGFloat y = _grayLabel.frame.origin.y + _grayLabel.frame.size.height + 20.0f;
        CGFloat width = 47.0f;
        CGFloat height = 16.0f;
        
        _refundLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _refundLabel.text = @"退款到";
        _refundLabel.textAlignment = NSTextAlignmentLeft;
        _refundLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _refundLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _refundLabel.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_refundLabel];
    }
    return _refundLabel;
}

-(PaymentView *)paymentView
{
    if (!_paymentView) {
        CGFloat x = 0.0f;
        CGFloat y = _refundLabel.frame.origin.y + _refundLabel.frame.size.height + 13.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 91.0f;
        
        _paymentView = [[PaymentView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _paymentView.delegate = self;
        [self.view addSubview:_paymentView];
    }
    return _paymentView;
}

-(UIButton *)submit
{
    if (!_submit) {
        CGFloat height = 44.0f;
        CGFloat x = 30.0f;
        CGFloat y = [GeneralSize getMainScreenHeight] - height - 31.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        
        _submit = [UIButton buttonWithType:UIButtonTypeCustom];
        _submit.frame = CGRectMake(x, y, width, height);
        [_submit setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_submit setTitle:@"退款" forState:UIControlStateNormal];
        [_submit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submit];
    }
    return _submit;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"退款"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.payType = PaymentAlipay;
    
    [self refundView];
    [self grayLabel];
    [self refundLabel];
    [self paymentView];
    [self submit];
    
    [self.refundView setAccountBalance:[self.balance copy]];
}

#pragma mark - PaymentViewDelegate
-(void)clickWithPaymentItem:(PaymentType)payType
{
    _payType = payType;
}

#pragma mark - private method
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 退款
-(void)submitClick
{
    NSString *balance = [self.balance copy]; // 账户余额
    NSString *paymentAmount = [self.refundView.textField.text mutableCopy]; // 输入的金额
    if ([paymentAmount floatValue] <= 0) {
        [CustomAlertView showWithWarnMessage:@"请输入退款金额"];
        return;
    }
    if ([paymentAmount integerValue] > [balance integerValue]) {
        [CustomAlertView showWithWarnMessage:@"账户余额不足"];
        return;
    }
    if (_payType == PaymentAlipay) { // 支付宝
        [self setRefundBalanceByAlipayWithAmount:paymentAmount];
    } else if (_payType == PaymentWeChat) { // 微信
        [self setRefundBalanceByWechatWithAmount:paymentAmount];
    }
}

// 支付宝退款
-(void)setRefundBalanceByAlipayWithAmount:(NSString *)amount
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAlipayRefund];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"paymentAmount" : amount};
    
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        [CustomAlertView showWithSuccessMessage:OperationSuccess];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

// 微信退款
-(void)setRefundBalanceByWechatWithAmount:(NSString *)amount
{

    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixWechatRefund];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"paymentAmount" : amount};
    
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary - %@",resultDictionary);
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        [CustomAlertView showWithSuccessMessage:OperationSuccess];

    } failure:^(NSError *error) {
        NSLog(@"error - %@",error);
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
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
