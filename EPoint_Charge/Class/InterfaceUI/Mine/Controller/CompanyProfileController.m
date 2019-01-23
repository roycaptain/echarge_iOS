//
//  CompanyProfileController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/22.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "CompanyProfileController.h"

@interface CompanyProfileController ()

@property(nonatomic,strong)UITextView *profileView;

@end

@implementation CompanyProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self startRequestNetwork];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle]; // NavigationBar 由透明状态切换到不透明的状态
}

#pragma mark - private method
-(void)startRequestNetwork
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixCompanyDesc];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    
    [CustomAlertView show];
    __weak typeof(self) weakSelf = self;
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:NULL successful:^(NSDictionary *resultDic) {
        
        [CustomAlertView hide];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"msg"];
        NSString *data = resultDic[@"data"];
        
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return ;
        }
        NSString *content = data ? data : @"";
        weakSelf.profileView.attributedText = [weakSelf setStringJustifyAlign:content];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(UITextView *)profileView
{
    if (!_profileView) {
        CGFloat x = 15.0f;
        CGFloat y = 93.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = [GeneralSize getMainScreenHeight] - y - x;
        
        _profileView = [[UITextView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _profileView.editable = NO;
        _profileView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_profileView];
    }
    return _profileView;
}

#pragma mark - private method
-(void)initUI
{
    [super setNavigationTitle:@"公司简介"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    [super setNavigationBarBackItem];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    [self profileView];
}

/*
 设置两端对齐
 */
-(NSAttributedString *)setStringJustifyAlign:(NSString *)text
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;

    NSDictionary *dictionary = @{
                                 NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"],
                                 NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:14.0f],
                                 NSParagraphStyleAttributeName : paragraphStyle,
                                 NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleNone]
                                 };
    [attributeString setAttributes:dictionary range:NSMakeRange(0, attributeString.length)];
    NSAttributedString *astring = [attributeString copy];
    return astring;
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
