//
//  ChangePWResultController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/23.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "ChangePWResultController.h"
#import "ResultStatusView.h"
#import "SetupController.h"

@interface ChangePWResultController ()

@property(nonatomic,strong)ResultStatusView *statusView;
@property(nonatomic,strong)UIButton *knowItem;

@end

@implementation ChangePWResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *navigationBarTitle = (self.resultStatus == ResultStatusSuccessed) ? @"修改成功" : @"修改失败";
    NSString *imageName = (self.resultStatus == ResultStatusSuccessed) ? @"change_result_success" : @"change_result_failed";
    NSString *title = (self.resultStatus == ResultStatusSuccessed) ? @"修改成功!" : @"修改失败!";
    NSString *detailTitle = (self.resultStatus == ResultStatusSuccessed) ? @"" : self.alertText;
    
    [super setHideNavigationBarBackItem];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
    [self statusView];
    [self knowItem];
    
    [super setNavigationTitle:navigationBarTitle];
    [_statusView setStatusImageViewWithImageName:imageName];
    [_statusView setStatusTitle:title];
    [_statusView setStatusDetailTitle:detailTitle];
}

#pragma mark - lazy load
-(ResultStatusView *)statusView
{
    if (!_statusView) {
        CGFloat x = 0.0f;
        CGFloat y = 150.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 160.0f;
        
        _statusView = [[ResultStatusView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_statusView];
    }
    return _statusView;
}

-(UIButton *)knowItem
{
    if (!_knowItem) {
        CGFloat x = 30.0f;
        CGFloat y = _statusView.frame.origin.y + _statusView.frame.size.height + 27.0f;
        CGFloat width = [GeneralSize getMainScreenWidth] - x * 2;
        CGFloat height = 44.0f;
        
        _knowItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _knowItem.frame = CGRectMake(x, y, width, height);
        _knowItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
        [_knowItem setTitle:@"我知道了" forState:UIControlStateNormal];
        [_knowItem setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        [_knowItem setBackgroundImage:[UIImage imageNamed:@"bton_bg_clickable"] forState:UIControlStateNormal];
        [_knowItem addTarget:self action:@selector(knowClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_knowItem];
    }
    return _knowItem;
}

#pragma mark - click
-(void)knowClick
{
    self.resultStatus == ResultStatusSuccessed ? [self popSetupController] : [self popChangePWController];
}

#pragma mark - 修改成功返回设置界面 修改失败返回上一个页面
-(void)popSetupController
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SetupController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

-(void)popChangePWController
{
    [self.navigationController popViewControllerAnimated:YES];
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
