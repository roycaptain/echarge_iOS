//
//  RechargeController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "RechargeController.h"
#import "RechargeView.h"
#import "PaymentView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface RechargeController ()<RechargeViewDelegate,PaymentViewDelegate>

@property(nonatomic,strong)UILabel *amountLabel; // 充值金额
@property(nonatomic,strong)RechargeView *rechargeView;
@property(nonatomic,strong)UILabel *payment; // 支付方式
@property(nonatomic,strong)PaymentView *paymentView;
@property(nonatomic,strong)UIButton *submit; // 立即充值

@property(nonatomic,copy)NSString *amount; // 金额
@property(nonatomic,assign)PaymentType type; // 充值类型

@end

@implementation RechargeController

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

#pragma mark - lazy load
-(UILabel *)amountLabel
{
    if (!_amountLabel) {
        CGFloat x = 15.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 13.0f;
        CGFloat width = 63.0f;
        CGFloat height = 16.0f;
        
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _amountLabel.text = @"充值金额";
        _amountLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _amountLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _amountLabel.adjustsFontSizeToFitWidth = YES;
        _amountLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_amountLabel];
    }
    return _amountLabel;
}

-(RechargeView *)rechargeView
{
    if (!_rechargeView) {
        CGFloat x = 0.0f;
        CGFloat y = _amountLabel.frame.origin.y + _amountLabel.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 110.0f;
        
        _rechargeView = [[RechargeView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _rechargeView.delegate = self;
        [self.view addSubview:_rechargeView];
    }
    return _rechargeView;
}

-(UILabel *)payment
{
    if (!_payment) {
        CGFloat x = 15.0f;
        CGFloat y = _rechargeView.frame.origin.y + _rechargeView.frame.size.height + 20.0f;
        CGFloat width = 63.0f;
        CGFloat height = 16.0f;
        
        _payment = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _payment.text = @"支付方式";
        _payment.textColor = [UIColor colorWithHexString:@"#000000"];
        _payment.textAlignment = NSTextAlignmentLeft;
        _payment.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _payment.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:_payment];
    }
    return _payment;
}

-(PaymentView *)paymentView
{
    if (!_paymentView) {
        CGFloat x = 0.0f;
        CGFloat y = _payment.frame.origin.y + _payment.frame.size.height + 13.0f;
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
        [_submit setTitle:@"立即充值" forState:UIControlStateNormal];
        [_submit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submit];
    }
    return _submit;
}

-(NSString *)amount
{
    if (!_amount) {
        _amount = [[NSString alloc] init];
        _amount = @"10";
    }
    return _amount;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"账户充值"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.type = PaymentAlipay;
    [self amount];
    [self amountLabel];
    [self rechargeView];
    [self payment];
    [self paymentView];
    [self submit];
}

#pragma mark - RechargeViewDelegate
-(void)rechargeItemClickWithTitle:(NSString *)title
{
    _amount = [NSString stringWithFormat:@"%@",[title stringByReplacingOccurrencesOfString:@"元" withString:@""]];
}

#pragma mark - PaymentViewDelegate
-(void)clickWithPaymentItem:(PaymentType)payType
{
    _type = payType;
}

#pragma mark - submitClick 立即充值
-(void)submitClick
{
    if (_type == PaymentAlipay) {
        [self setAlipayOrderRequestWithAmount:_amount];
    } else if (_type == PaymentWeChat) {
        [self setWeChatOrderRequestWithAmount:_amount];
    }
}


#pragma mark - 支付宝订单创建
-(void)setAlipayOrderRequestWithAmount:(NSString *)paymentAmount
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAlipayPay];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"paymentAmount" : paymentAmount};
    
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        [CustomAlertView hide];
        NSString *code = result[@"code"];
        NSString *msg = result[@"msg"];
        
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        NSString *data = result[@"data"];
        NSString *appScheme = @"EPointCharge";
        [[AlipaySDK defaultService] payOrder:data fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"resultDic - %@",resultDic);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Alipay error - %@",error);
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - 微信支付
-(void)setWeChatOrderRequestWithAmount:(NSString *)paymentAmount
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixWechatPay];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"paymentAmount" : paymentAmount};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *result) {
        NSLog(@"result - %@",result);
        [CustomAlertView hide];
        NSString *code = result[@"code"];
        NSString *msg = result[@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        NSDictionary *data = result[@"data"];
        [weakSelf WechatPay:data]; // 调起微信支付
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
        NSLog(@"error - %@",error);
    }];
    
}

-(void)WechatPay:(NSDictionary *)dictionary
{
    PayReq *req = [[PayReq alloc] init];
    req.openID = dictionary[@"appId"];
    req.partnerId = dictionary[@"partnerId"];
    req.prepayId = dictionary[@"prepayId"];
    req.package = @"Sign=WXPay";
    req.nonceStr = dictionary[@"nonceStr"];
    req.timeStamp = [dictionary[@"timeStamp"] intValue];
    req.sign = dictionary[@"paySign"];
    [WXApi sendReq:req];
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
