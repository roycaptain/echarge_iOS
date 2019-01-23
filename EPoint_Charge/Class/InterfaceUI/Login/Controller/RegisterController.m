//
//  RegisterController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "RegisterController.h"
#import "TopBGView.h"
#import "LoginTextField.h"
#import "TextFieldWithSecuryItem.h"
#import "TextFieldWithIdentifyItem.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"

CGFloat const XPoint = 30.0f; // x坐标
CGFloat const TextFieldHeight = 28.0f; // 输入框的高度
CGFloat const TextFieldSpace = 24.0f; // 输入框之间的距离;
#define TextFieldWidth [GeneralSize getMainScreenWidth] - XPoint * 2; // 输入框的宽度
#define RegisterVCTopBGHeight [GeneralSize getMainScreenHeight] / 3

const NSTimeInterval RAnimationDuration = 0.5f;

@interface RegisterController ()<TextFieldWithIdentifyItemDelegate>

@property(nonatomic,strong)TopBGView *topBGView;
@property(nonatomic,strong)LoginTextField *phoneField; // 手机号
@property(nonatomic,strong)TextFieldWithIdentifyItem *identifyField; // 验证码
@property(nonatomic,strong)TextFieldWithSecuryItem *pwField; // 密码
@property(nonatomic,strong)TextFieldWithSecuryItem *confirmPWField; // 确认密码

@property(nonatomic,strong)UIButton *registerItem; // 注册按钮
@property(nonatomic,strong)UIButton *goLogin; // 去登陆按钮

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:NULL];
    // 键盘消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:NULL];
    
    [self initUI];
    
}

#pragma mark - lazy load
-(UIImageView *)topBGView
{
    if (!_topBGView) {
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = RegisterVCTopBGHeight;
        _topBGView = [[TopBGView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.view addSubview:_topBGView];
    }
    return _topBGView;
}

-(LoginTextField *)phoneField
{
    if (!_phoneField) {
        CGFloat x = XPoint;
        CGFloat y = RegisterVCTopBGHeight + 35.0f;
        CGFloat width = TextFieldWidth;
        CGFloat height = TextFieldHeight;
        
        _phoneField = [[LoginTextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_phoneField setTextFieldPlaceHolder:@"请输入手机号码"];
        [self.view addSubview:_phoneField];
    }
    return _phoneField;
}

-(TextFieldWithIdentifyItem *)identifyField
{
    if (!_identifyField) {
        CGFloat x = XPoint;
        CGFloat y = _phoneField.frame.origin.y + _phoneField.frame.size.height + TextFieldSpace;
        CGFloat width = TextFieldWidth;
        CGFloat height = TextFieldHeight;
        
        _identifyField = [[TextFieldWithIdentifyItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_identifyField setTextFieldPlaceHolder:@"请输入验证码"];
        _identifyField.delegate = self;
        [self.view addSubview:_identifyField];
    }
    return _identifyField;
}

-(TextFieldWithSecuryItem *)pwField
{
    if (!_pwField) {
        CGFloat x = XPoint;
        CGFloat y = _identifyField.frame.origin.y + _identifyField.frame.size.height + TextFieldSpace;
        CGFloat width = TextFieldWidth;
        CGFloat height = TextFieldHeight;
        
        _pwField = [[TextFieldWithSecuryItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_pwField setTextFieldPlaceHolder:@"请输入密码"];
        [self.view addSubview:_pwField];
    }
    return _pwField;
}

-(TextFieldWithSecuryItem *)confirmPWField
{
    if (!_confirmPWField) {
        CGFloat x = XPoint;
        CGFloat y = _pwField.frame.origin.y + _pwField.frame.size.height + TextFieldSpace;
        CGFloat width = TextFieldWidth;
        CGFloat height = TextFieldHeight;
        
        _confirmPWField = [[TextFieldWithSecuryItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_confirmPWField setTextFieldPlaceHolder:@"请再次输入密码"];
        [self.view addSubview:_confirmPWField];
    }
    return _confirmPWField;
}

// 注册按钮
-(UIButton *)registerItem
{
    if (!_registerItem) {
        CGFloat x = XPoint;
        CGFloat y = _confirmPWField.frame.origin.y + _confirmPWField.frame.size.height + 40.0f;
        CGFloat width = TextFieldWidth;
        CGFloat height = 44.0f;
        
        _registerItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerItem.frame = CGRectMake(x, y, width, height);
        [_registerItem setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_registerItem setTitle:@"注册" forState:UIControlStateNormal];
        [_registerItem addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerItem];
    }
    return _registerItem;
}

// 去登陆按钮
-(UIButton *)goLogin
{
    if (!_goLogin) {
        NSString *title = @"去登录";
        CGFloat fontSize = 14.0f;
        
        CGFloat height = 13.0f;
        CGFloat width = [GeneralSize calculateStringWidth:title withFontSize:fontSize withStringHeight:height];
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = _registerItem.frame.origin.y + _registerItem.frame.size.height + 15.0f;
        
        _goLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _goLogin.frame = CGRectMake(x, y, width, height);
        _goLogin.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
        [_goLogin setTitle:title forState:UIControlStateNormal];
        [_goLogin setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        [_goLogin addTarget:self action:@selector(goLoginClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goLogin];
    }
    return _goLogin;
}


#pragma mark - private method
-(void)initUI
{
    [self topBGView];
    [self phoneField];
    [self identifyField];
    [self pwField];
    [self confirmPWField];
    [self registerItem];
    [self goLogin];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 注册事件
-(void)registerClick
{
    NSString *mobile = _phoneField.textField.text; // 手机号
    NSString *verifyCode = _identifyField.textField.text; // 验证码
    NSString *password = _pwField.textField.text; // 密码
    NSString *confirmPW = _confirmPWField.textField.text; // 确认密码

    if (![Common checkPhoneNumInput:mobile]) {// 验证手机号码
        [CustomAlertView showWithWarnMessage:@"手机号有误!"];
        return;
    }
    if ([Common checkIdentifyCodeInput:verifyCode]) {
        [CustomAlertView showWithWarnMessage:@"请输入验证码!"];
        return;
    }
    if ([Common checkPasswordInput:password]) {
        [CustomAlertView showWithWarnMessage:@"请输入密码!"];
        return;
    }
    if ([Common checkPasswordInput:confirmPW]) {
        [CustomAlertView showWithWarnMessage:@"请再次输入密码!"];
        return;
    }
    if (![password isEqualToString:confirmPW]) {
        [CustomAlertView showWithWarnMessage:@"两次密码不一致!"];
        return;
    }

    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixUserRegister];
    NSDictionary *paramDic = @{@"mobile" : mobile,@"verifyCode" : verifyCode,@"password" : password,@"companyCode" : CompanyCode};
    
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestUrl WithHTTPHeaderFieldDictionary:NULL withParamDictionary:paramDic successful:^(NSDictionary *resultDictionary) {
        
        [CustomAlertView hide];
        
        NSString *code = [resultDictionary objectForKey:@"code"];
        NSString *msg = [resultDictionary objectForKey:@"msg"];
        
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        
        NSString *accessToken = [[resultDictionary objectForKey:@"data"] objectForKey:@"access_token"];
        [[UserInfoManager shareInstance] saveUserInfoPhoneNum:mobile andAccessToken:accessToken];
        [CustomAlertView showWithSuccessMessage:msg];
        [weakSelf dismissViewControllerAnimated:YES completion:NULL];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
        app.window.rootViewController = mainTabBarController;
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

// 去登陆
-(void)goLoginClick
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - TextFieldWithIdentifyItemDelegate
// 获取验证码按钮点击事件
-(void)TextFieldWithIdentifyItemClick
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixAppSmsCode];
    NSString *mobile = _phoneField.textField.text;
    
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
        NSLog(@"error - %@",error);
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - Keyboard 键盘上移下移
- (void)registerKeyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo]; // 获取键盘通知信息
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]; // 获取键盘的 Rect
    CGSize keyboardSize = keyboardRect.size;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:RAnimationDuration animations:^{
        
        CGFloat keyboardHeight = keyboardSize.height; // 键盘的高度
        UIView *currentView;
        for (UIView *view in @[weakSelf.phoneField.textField,weakSelf.identifyField.textField,weakSelf.pwField.textField,weakSelf.confirmPWField.textField]) {
            if ([view isFirstResponder]) {
                currentView = [view superview];
            }
        }
        CGFloat viewToBottom = weakSelf.view.frame.size.height - CGRectGetMaxY(currentView.frame) - 10.0f;
        CGFloat offeet = viewToBottom - keyboardHeight;
        if (offeet < 0) {
            weakSelf.view.frame = CGRectMake(0.0f, offeet, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
        }
    }];
}

///键盘消失事件
- (void)registerKeyboardWillHide:(NSNotification *)notification {

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:RAnimationDuration animations:^{
        weakSelf.view.frame = CGRectMake(0.0f, 0.0f, [GeneralSize getMainScreenWidth], [GeneralSize getMainScreenHeight]);
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
