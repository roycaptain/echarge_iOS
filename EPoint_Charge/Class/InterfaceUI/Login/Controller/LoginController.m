//
//  LoginController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/20.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "LoginController.h"
#import "TopBGView.h"
#import "LoginSlideView.h"
#import "RegisterController.h"
#import "ForgetPWController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"

#define LoginVCTopBGHeight [GeneralSize getMainScreenHeight] / 3

@interface LoginController ()<LoginSlideViewDelegate>

@property(nonatomic,strong)TopBGView *topBGView;
@property(nonatomic,strong)LoginSlideView *slideView; // 滑动选项登陆视图
@property(nonatomic,strong)UIButton *loginBtn; // 登陆按钮
@property(nonatomic,strong)UIButton *registerBtn; //注册按钮
@property(nonatomic,strong)UIButton *forgetBtn; // 忘记密码

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginKeyboardWillShow:) name:UIKeyboardWillShowNotification object:NULL];
    // 键盘消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginKeyboardWillHide:) name:UIKeyboardWillHideNotification object:NULL];
    
    [self initUI];

}

#pragma mark - lazy load
-(TopBGView *)topBGView
{
    if (!_topBGView) {
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = LoginVCTopBGHeight;
        _topBGView = [[TopBGView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.view addSubview:_topBGView];
    }
    return _topBGView;
}

-(LoginSlideView *)slideView
{
    if (!_slideView) {
        CGFloat x = 0.0f;
        CGFloat y = _topBGView.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 150.0f;
        _slideView = [[LoginSlideView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _slideView.delegate = self;
        [self.view addSubview:_slideView];
    }
    return _slideView;
}

-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = 30.0f;
        CGFloat y = _slideView.frame.origin.y + _slideView.frame.size.height + 40.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 44.0f;
        _loginBtn.frame = CGRectMake(x, y, width, height);
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

-(UIButton *)registerBtn
{
    if (!_registerBtn) {
        NSString *title = @"注册";
        CGFloat fontSize = 14.0f;
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = 40.0f;
        CGFloat y = _loginBtn.frame.origin.y + _loginBtn.frame.size.height + 15.0f;
        CGFloat height = 13.0f;
        CGFloat width = [GeneralSize calculateStringWidth:title withFontSize:fontSize withStringHeight:height];
        _registerBtn.frame = CGRectMake(x, y, width, height);
        _registerBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
        [_registerBtn setTitle:title forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerBtn];
    }
    return _registerBtn;
}

-(UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        NSString *title = @"忘记密码?";
        CGFloat fontSize = 14.0f;
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat height = 13.0f;
        CGFloat width = [GeneralSize calculateStringWidth:title withFontSize:fontSize withStringHeight:height];
        CGFloat x = [GeneralSize getMainScreenWidth] - 40.0f - width;
        CGFloat y = _loginBtn.frame.origin.y + _loginBtn.frame.size.height + 15.0f;
        _forgetBtn.frame = CGRectMake(x, y, width, height);
        _forgetBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
        [_forgetBtn setTitle:title forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_forgetBtn];
    }
    return _forgetBtn;
}

#pragma mark - private method
-(void)initUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self topBGView];
    [self slideView];
    [self loginBtn];
    [self registerBtn];
    [self forgetBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)redirectTargetController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *rootViewController = appDelegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[LoginController class]]) {
        MainTabBarController *mainTabBar = [[MainTabBarController alloc] init];
        appDelegate.window.rootViewController = mainTabBar;
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - click
// 登陆
-(void)loginClick
{
    [self.view endEditing:YES];
    LoginType loginType = _slideView.loginType; // 登陆方式
    NSString *model = [NSString stringWithFormat:@"%lu",(unsigned long)loginType]; // 登陆方式
    
    NSString *mobile = (loginType == PassWordLogin) ? _slideView.pwLandView.accountField.textField.text : _slideView.codeLandView.accountField.textField.text; // 账号
    NSString *password = _slideView.pwLandView.passWordField.textField.text; // 密码
    NSString *verifyCode = _slideView.codeLandView.identifyField.textField.text; // 验证码
    
    BOOL phoneCheck = [Common checkPhoneNumInput:mobile]; // 验证手机号码
    if (!phoneCheck) {
        [CustomAlertView showWithWarnMessage:@"手机号有误!"];
        return;
    }
    if (loginType == PassWordLogin && [Common checkPasswordInput:password]) { // 账号密码登陆
        [CustomAlertView showWithWarnMessage:@"请输入密码"];
        return;
    }
    if (loginType == IdentifyLogin && !verifyCode) { // 验证码登陆
        [CustomAlertView showWithWarnMessage:@"请输入验证码"];
        return;
    }
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixUserLogin];
    NSDictionary *paramPWDic = @{@"model" : model,
                               @"mobile" : mobile,
                               @"password" : password,
                               @"companyCode" : CompanyCode,
                                 @"clientType" : @"IOS",
                                 };
    NSDictionary *paramIdentifyDic = @{@"model" : model,
                                       @"mobile" : mobile,
                                       @"verifyCode" : verifyCode,
                                       @"companyCode" : CompanyCode,
                                       @"clientType" : @"IOS",
                                       };
    NSDictionary *paramDic = (loginType == PassWordLogin) ? paramPWDic : paramIdentifyDic;
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestUrl WithHTTPHeaderFieldDictionary:NULL withParamDictionary:paramDic successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        
        NSString *code = [resultDictionary objectForKey:@"code"];
        NSString *msg = [resultDictionary objectForKey:@"msg"];
        
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        // 存储用户信息(手机号和访问令牌)
        NSString *accessToken = [[resultDictionary objectForKey:@"data"] objectForKey:@"access_token"];
        BOOL result = [[UserInfoManager shareInstance] saveUserInfoPhoneNum:mobile andAccessToken:accessToken];
        if (!result) {
            [CustomAlertView  showWithFailureMessage:OperationFailure]; // 数据保存失败
            return;
        }
        [CustomAlertView showWithSuccessMessage:@"登陆成功"];
        [weakSelf redirectTargetController];
        
    } failure:^(NSError *error) {
        NSLog(@"err0- %@",error);
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];

}

// 注册
-(void)registerClick
{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    RegisterController *registerVC = [loginSB instantiateViewControllerWithIdentifier:@"RegisterController"];
    [self presentViewController:registerVC animated:YES completion:NULL];
}

// 忘记密码
-(void)forgetClick
{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    ForgetPWController *forgetVC = [loginSB instantiateViewControllerWithIdentifier:@"ForgetPWController"];
    [self presentViewController:forgetVC animated:YES completion:NULL];
}



#pragma mark - LoginSlideViewDelegate
// 点击滑动按钮
-(void)loginTypeClick:(LoginType)loginType
{
    _slideView.loginType = loginType;
}

// 获取验证码
-(void)loginSlideViewIdentifyClick
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAppSmsCode];
    NSString *mobile = _slideView.codeLandView.accountField.textField.text;
    
    BOOL phoneCheck = [Common checkPhoneNumInput:mobile]; // 验证手机号码
    if (!phoneCheck) {
        [CustomAlertView showWithWarnMessage:@"手机号有误!"];
        return;
    }
    NSDictionary *bodyParam = @{@"mobile" : mobile,@"companyCode" : CompanyCode,@"clientType" : @"IOS"};
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:NULL withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        [CustomAlertView showWithSuccessMessage:@"发送成功"];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - Keyboard 键盘上移下移
- (void)loginKeyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo]; // 获取键盘通知信息
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; // 获取键盘的 Rect
    CGSize keyboardSize = keyboardRect.size;
    CGFloat keyboardHeight = keyboardSize.height; // 键盘的高度
    
    [UIView animateWithDuration:RAnimationDuration animations:^{
        
        UIView *currentView;
        for (UIView *view in @[self.slideView.pwLandView.accountField.textField,
                               self.slideView.pwLandView.passWordField.textField,
                               self.slideView.codeLandView.accountField.textField,
                               self.slideView.codeLandView.identifyField.textField]) {
            if ([view isFirstResponder]) {
                currentView = [[[[view superview] superview] superview] superview];
            }
        }
        CGFloat viewToBottom = self.view.frame.size.height - CGRectGetMaxY(currentView.frame) - 10.0f;
        CGFloat offeet = viewToBottom - keyboardHeight;
        if (offeet < 0) {
            self.view.frame = CGRectMake(0.0f, offeet, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
        }
    }];
}

///键盘消失事件
- (void)loginKeyboardWillHide:(NSNotification *)notification {
    
    [UIView animateWithDuration:RAnimationDuration animations:^{
        self.view.frame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:NULL];
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
