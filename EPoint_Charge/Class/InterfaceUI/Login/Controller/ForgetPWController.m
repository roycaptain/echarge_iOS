//
//  ForgetPWController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/21.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ForgetPWController.h"
#import "TopBGView.h"
#import "LoginTextField.h"
#import "TextFieldWithIdentifyItem.h"
#import "TextFieldWithSecuryItem.h"

CGFloat const FTextFieldXPoint = 30.0f; // x坐标
CGFloat const FTextFieldHeight = 28.0f; // 输入框的高度
CGFloat const FTextFieldSpace = 44.0f; // 输入框之间的距离;
#define FTextFieldWidth [GeneralSize getMainScreenWidth] - FTextFieldXPoint * 2 // 输入框的宽度
#define ForgetVCTopBGHeight [GeneralSize getMainScreenHeight] / 3

@interface ForgetPWController ()<TextFieldWithIdentifyItemDelegate>

@property(nonatomic,strong)TopBGView *topBGView;
@property(nonatomic,strong)LoginTextField *phoneField; // 手机号
@property(nonatomic,strong)TextFieldWithIdentifyItem *identifyField; // 验证码
@property(nonatomic,strong)TextFieldWithSecuryItem *pwField; // 密码
@property(nonatomic,strong)UIButton *confirmItem; // 确认按钮
@property(nonatomic,strong)UIButton *goLogin; // 去登录

@property(nonatomic,copy)NSString *identify; // 验证码

@end

@implementation ForgetPWController

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
        CGFloat height = ForgetVCTopBGHeight;
        _topBGView = [[TopBGView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.view addSubview:_topBGView];
    }
    return _topBGView;
}

-(LoginTextField *)phoneField
{
    if (!_phoneField) {
        CGFloat x = FTextFieldXPoint;
        CGFloat y = ForgetVCTopBGHeight + 35.0f;
        CGFloat width = FTextFieldWidth;
        CGFloat height = FTextFieldHeight;

        _phoneField = [[LoginTextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_phoneField setTextFieldPlaceHolder:@"请输入手机号码"];
        [self.view addSubview:_phoneField];
    }
    return _phoneField;
}

-(TextFieldWithIdentifyItem *)identifyField
{
    if (!_identifyField) {
        CGFloat x = FTextFieldXPoint;
        CGFloat y = _phoneField.frame.origin.y + _phoneField.frame.size.height + FTextFieldSpace;
        CGFloat width = FTextFieldWidth;
        CGFloat height = FTextFieldHeight;

        _identifyField = [[TextFieldWithIdentifyItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _identifyField.delegate = self;
        [_identifyField setTextFieldPlaceHolder:@"请输入验证码"];
        [self.view addSubview:_identifyField];
    }
    return _identifyField;
}

-(TextFieldWithSecuryItem *)pwField
{
    if (!_pwField) {
        CGFloat x = FTextFieldXPoint;
        CGFloat y = _identifyField.frame.origin.y + _identifyField.frame.size.height + FTextFieldSpace;
        CGFloat width = FTextFieldWidth;
        CGFloat height = FTextFieldHeight;
        
        _pwField = [[TextFieldWithSecuryItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_pwField setTextFieldPlaceHolder:@"请输入新密码"];
        [self.view addSubview:_pwField];
    }
    return _pwField;
}

-(UIButton *)confirmItem
{
    if (!_confirmItem) {
        CGFloat x = FTextFieldXPoint;
        CGFloat y = _pwField.frame.origin.y + _pwField.frame.size.height + 40.0f;
        CGFloat width = FTextFieldWidth;
        CGFloat height = 44.0f;
        
        _confirmItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmItem.frame = CGRectMake(x, y, width, height);
        [_confirmItem setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmItem setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_confirmItem addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_confirmItem];
    }
    return _confirmItem;
}

-(UIButton *)goLogin
{
    if (!_goLogin) {
        NSString *title = @"去登录";
        CGFloat fontSize = 14.0f;
        
        CGFloat height = 13.0f;
        CGFloat width = [GeneralSize calculateStringWidth:title withFontSize:fontSize withStringHeight:height];
        CGFloat x = [GeneralSize getMainScreenWidth] / 2 - width / 2;
        CGFloat y = _confirmItem.frame.origin.y + _confirmItem.frame.size.height + 15.0f;
        
        _goLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        _goLogin.frame = CGRectMake(x, y, width, height);
        [_goLogin setTitle:title forState:UIControlStateNormal];
        [_goLogin setTitleColor:[UIColor colorWithHexString:@"#02B1CD"] forState:UIControlStateNormal];
        _goLogin.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
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
    [self confirmItem];
    [self goLogin];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)confirmClick
{
    NSString *mobile = _phoneField.textField.text; // 手机号
    NSString *verifyCode = _identifyField.textField.text; // 验证码
    NSString *rstPassword = _pwField.textField.text; // 重置后的密码
    
    if (![Common checkPhoneNumInput:mobile]) {
        [CustomAlertView showWithWarnMessage:@"请输入正确的手机号"];
        return;
    }
    if ([Common checkIdentifyCodeInput:verifyCode]) {
        [CustomAlertView showWithWarnMessage:@"验证码有误!"];
        return;
    }
    if ([Common checkPasswordInput:rstPassword]) {
        [CustomAlertView showWithWarnMessage:@"密码有误!"];
        return;
    }
    
    [CustomAlertView show];
    NSDictionary *parameter = @{@"mobile" : mobile,
                            @"verifyCode" : verifyCode,
                            @"rstPassword" : rstPassword,
                            @"companyCode" : CompanyCode};
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixResetPWD];
    
    [[DDNetworkRequest shareInstance] requestPUTWithURLString:requestURL WithHTTPHeaderFieldDictionary:NULL withParamDictionary:parameter successful:^(NSDictionary *resultDictionary) {
        
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] == RequestNetworkSuccess) {
            [CustomAlertView showWithSuccessMessage:OperationSuccess];
        } else {
            [CustomAlertView showWithFailureMessage:msg];
        }
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
    }];
}

-(void)goLoginClick
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - TextFieldWithIdentifyItemDelegate
// 获取验证码
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
    [UIView animateWithDuration:0.5f animations:^{
        
        CGFloat keyboardHeight = keyboardSize.height; // 键盘的高度
        UIView *currentView;
        for (UIView *view in @[weakSelf.phoneField.textField,weakSelf.identifyField.textField,weakSelf.pwField.textField]) {
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
    [UIView animateWithDuration:05.f animations:^{
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
