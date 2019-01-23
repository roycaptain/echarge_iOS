//
//  ChangePWController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChangePWController.h"
#import "LoginTextField.h"
#import "TextFieldWithSecuryItem.h"
#import "ChangePWResultController.h"

@interface ChangePWController ()

@property(nonatomic,strong)LoginTextField *phoneField; // 手机号码
@property(nonatomic,strong)TextFieldWithSecuryItem *pwField; // 新密码
@property(nonatomic,strong)TextFieldWithSecuryItem *confirmField; //
@property(nonatomic,strong)UIButton *saveItem; // 保存

@end

@implementation ChangePWController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - lazy load
-(LoginTextField *)phoneField
{
    if (!_phoneField) {
        CGFloat x = 30.0f;
        CGFloat y = 153.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 28.0f;
        
        _phoneField = [[LoginTextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_phoneField setTextFieldPlaceHolder:@"请输入手机号码"];
        [self.view addSubview:_phoneField];
    }
    return _phoneField;
}

-(TextFieldWithSecuryItem *)pwField
{
    if (!_pwField) {
        CGFloat x = 30.0f;
        CGFloat y = _phoneField.frame.origin.y + _phoneField.frame.size.height + 44.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 28.0f;
        
        _pwField = [[TextFieldWithSecuryItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_pwField setTextFieldPlaceHolder:@"请输入新密码"];
        [self.view addSubview:_pwField];
    }
    return _pwField;
}

-(TextFieldWithSecuryItem *)confirmField
{
    if (!_confirmField) {
        CGFloat x = 30.0f;
        CGFloat y = _pwField.frame.origin.y + _pwField.frame.size.height + 44.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 28.0f;
        
        _confirmField = [[TextFieldWithSecuryItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_confirmField setTextFieldPlaceHolder:@"请再次输入新密码"];
        [self.view addSubview:_confirmField];
    }
    return _confirmField;
}

-(UIButton *)saveItem
{
    if (!_saveItem) {
        CGFloat x = 30.0f;
        CGFloat y = _confirmField.frame.origin.y + _confirmField.frame.size.height + 70.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 44.0f;
        
        _saveItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveItem.frame = CGRectMake(x, y, width, height);
        _saveItem.titleLabel.font = [UIFont fontWithName:@"#FFFFFF" size:18.0f];
        [_saveItem setTitle:@"保存" forState:UIControlStateNormal];
        [_saveItem setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [_saveItem setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_saveItem addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveItem];
    }
    return _saveItem;
}

#pragma mark - private method
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"修改密码"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    
    [self phoneField];
    [self pwField];
    [self confirmField];
    [self saveItem];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - click
-(void)saveClick
{
    NSString *mobile = _phoneField.textField.text; // 手机号码
    NSString *pwNum = _pwField.textField.text; // 密码
    NSString *confirmNum = _confirmField.textField.text; // 确认密码
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    if (![Common checkPhoneNumInput:mobile]) {// 验证手机号码
        [CustomAlertView showWithWarnMessage:@"请输入正确的手机号码!"];
        return;
    }
    if ([Common checkPasswordInput:pwNum]) {
        [CustomAlertView showWithWarnMessage:@"请输入密码!"];
        return;
    }
    if ([Common checkPasswordInput:confirmNum]) {
        [CustomAlertView showWithWarnMessage:@"请输入新密码!"];
        return;
    }
    if (![pwNum isEqualToString:confirmNum]) {
        [CustomAlertView showWithWarnMessage:@"两次密码不一致!"];
        return;
    }
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixModPWD];
    NSDictionary *paramDic = @{@"mobile" : mobile,
                               @"modPassword" : confirmNum};
    NSDictionary *headerDic = @{@"access_token" : accessToken};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPUTWithURLString:requestUrl WithHTTPHeaderFieldDictionary:headerDic withParamDictionary:paramDic successful:^(NSDictionary *resultDictionary) {
        
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        
        if ([code integerValue] != RequestNetworkSuccess) {
            [weakSelf pushResultTargetControllerWithResultStatusType:ResultStatusFailed withAlertText:msg];
            return;
        }
        // 成功
        [weakSelf pushResultTargetControllerWithResultStatusType:ResultStatusSuccessed withAlertText:@""];
        
    } failure:^(NSError *error) { // 修改失败
        [CustomAlertView hide];
        [weakSelf pushResultTargetControllerWithResultStatusType:ResultStatusFailed withAlertText:NetworkingError];
    }];
}

// 修改密码接口根据返回结果跳转修改结果界面
-(void)pushResultTargetControllerWithResultStatusType:(ResultStatusType)result withAlertText:(NSString *)alertText
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    ChangePWResultController *resultVC = [mineSB instantiateViewControllerWithIdentifier:@"ChangePWResultController"];
    resultVC.resultStatus = result;
    resultVC.alertText = alertText;
    [self.navigationController pushViewController:resultVC animated:YES];
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
