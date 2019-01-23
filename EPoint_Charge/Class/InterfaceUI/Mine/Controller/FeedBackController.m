//
//  FeedBackController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/24.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "FeedBackController.h"

NSUInteger const MaxLength = 500;

@interface FeedBackController ()<UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITextView *textView; // 内容
@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)UIView *connectBGView;
@property(nonatomic,strong)UILabel *connectLabel;
@property(nonatomic,strong)UITextField *textField; // 联系方式
@property(nonatomic,strong)UIButton *submit;

@end

@implementation FeedBackController

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
-(UITextView *)textView
{
    if (!_textView) {
        CGFloat x = 0.0f;
        CGFloat y = 72.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 175.0f;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _textView.font = [UIFont systemFontOfSize:12.0f];
        _textView.textColor = [UIColor colorWithHexString:@"#999999"];
        _textView.text = @"请输入你遇到的问题和建议";
        _textView.delegate = self;
        [self.view addSubview:_textView];
    }
    return _textView;
}

-(UILabel *)countLabel
{
    if (!_countLabel) {
        CGFloat width = 34.0f;
        CGFloat height = 12.0f;
        CGFloat x = _textView.frame.size.width - 11.0f - width;
        CGFloat y = _textView.frame.size.height - 6.0f - 12.0f;
        
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _countLabel.text = @"0/500";
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:12.0f];
        _countLabel.adjustsFontSizeToFitWidth = YES;
        [_textView addSubview:_countLabel];
    }
    return _countLabel;
}

-(UIView *)connectBGView
{
    if (!_connectBGView) {
        CGFloat x = 0.0f;
        CGFloat y = _textView.frame.origin.y + _textView.frame.size.height + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 43.0f;
        
        _connectBGView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _connectBGView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self.view addSubview:_connectBGView];
    }
    return _connectBGView;
}

-(UILabel *)connectLabel
{
    if (!_connectLabel) {
        CGFloat width = 63.0f;
        CGFloat height = 16.0f;
        CGFloat x = 15.0f;
        CGFloat y = 13.0f;
        
        _connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _connectLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _connectLabel.text = @"联系方式";
        _connectLabel.textAlignment = NSTextAlignmentLeft;
        _connectLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f];
        _connectLabel.adjustsFontSizeToFitWidth = YES;
        [_connectBGView addSubview:_connectLabel];
    }
    return _connectLabel;
}

-(UITextField *)textField
{
    if (!_textField) {
        CGFloat x = _connectLabel.frame.origin.x + _connectLabel.frame.size.width + 23.0f;
        CGFloat y = _connectLabel.frame.origin.y;
        CGFloat width = [GeneralSize getMainScreenWidth] - x - 20.0f;
        CGFloat height = 16.0f;
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _textField.placeholder = @"邮箱/QQ/电话";
        _textField.delegate = self;
        [_connectBGView addSubview:_textField];
    }
    return _textField;
}

-(UIButton *)submit
{
    if (!_submit) {
        CGFloat x = 34.0f;
        CGFloat y = _connectBGView.frame.origin.y + _connectBGView.frame.size.height + 157.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 44.0f;
        
        _submit = [UIButton buttonWithType:UIButtonTypeCustom];
        _submit.frame = CGRectMake(x, y, width, height);
        [_submit setTitle:@"提交" forState:UIControlStateNormal];
        [_submit setBackgroundImage:[UIImage imageNamed:@"btn_bg_noclickable"] forState:UIControlStateNormal];
        [_submit addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        _submit.enabled = NO;
        [self.view addSubview:_submit];
    }
    return _submit;
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"意见反馈"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    [self textView];
    [self countLabel];
    [self connectBGView];
    [self connectLabel];
    [self textField];
    [self submit];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入你遇到的问题和建议"]) {
        textView.text = @"";
    }
    textView.textColor = [UIColor colorWithHexString:@"#333333"];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        textView.textColor = [UIColor colorWithHexString:@"#999999"];
        textView.text = @"请输入你遇到的问题和建议";
    }
    if (![textView.text isEqualToString:@"请输入你遇到的问题和建议"] && textView.text.length > 0 && self.textField.text.length > 0) {
        [_submit setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        _submit.enabled = YES;
    } else {
        [_submit setBackgroundImage:[UIImage imageNamed:@"btn_bg_noclickable"] forState:UIControlStateNormal];
        _submit.enabled = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];//当前的输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *range = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:range.start offset:0];
        if (!position) {
            [self checkText:textView];
        }
    }
    else {
        [self checkText:textView];
    }
}

- (void)checkText:(UITextView *)textView
{
    NSString *string = textView.text;
    
    if (string.length > MaxLength)
    {
        textView.text = [string substringToIndex:MaxLength];
    }
    
    NSInteger length = textView.text.length;
    _countLabel.text = [NSString stringWithFormat:@"%ld/500",(long)length];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self.textView.text isEqualToString:@"请输入你遇到的问题和建议"] && self.textView.text.length > 0 && self.textField.text.length > 0) {
        [_submit setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        _submit.enabled = YES;
    } else {
        [_submit setBackgroundImage:[UIImage imageNamed:@"btn_bg_noclickable"] forState:UIControlStateNormal];
        _submit.enabled = NO;
    }
}

#pragma mark - private method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)submitClick
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixFeedback];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerDictionary = @{@"access_token" : accessToken};
    NSDictionary *paramDict = @{@"problemDesc" : self.textView.text,
                                @"contactWay" : self.textField.text};
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:paramDict successful:^(NSDictionary *resultDictionary) {
        
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        [CustomAlertView showWithSuccessMessage:OperationSuccess];
        [weakSelf.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithFailureMessage:NetworkingError];
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
