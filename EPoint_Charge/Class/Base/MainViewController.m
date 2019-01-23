//
//  MainViewController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/16.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "LoginController.h"

@interface MainViewController ()

@property(nonatomic,strong)UIButton *leftItem;
@property(nonatomic,strong)UIView *leftCustomView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(UIButton *)leftItem
{
    if (!_leftItem) {
        _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _leftItem;
}

-(UIView *)leftCustomView
{
    if (!_leftCustomView) {
        _leftCustomView = [[UIView alloc] init];
    }
    return _leftCustomView;
}

#pragma mark private method
/*
 设置 NavigationBar 的标题
 */
-(void)setNavigationTitle:(NSString *)title
{
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = title;
}

/*
 设置 NavigationBar 标题的字体颜色
 */
-(void)setNavigationBarTitleFontSize:(CGFloat)fontSize andFontColor:(NSString *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor colorWithHexString:color]}];
}

/*
 隐藏 NavigationBar 返回按钮
 */
-(void)setHideNavigationBarBackItem
{
    self.navigationItem.hidesBackButton = YES;
}

/*
 自定义NavigationBar 返回按钮
 */
-(void)setNavigationBarBackItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
}

/*
 自定义NavigationBar 返回按钮的返回事件
 */
-(void)setNavigationBarBackItemWithTarget:(id)target action:(SEL)buttonAction
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:buttonAction];
}

/*
 设置 NavigationBar 为透明样式
 */
-(void)setNavigationBarClearStyle
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/*
 NavigationBar 由透明样式切换到不透明样式
 */
-(void)setNavigationBarOpaqueStyle
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

/*
 设置找桩界面 leftBarButtonItem 样式
 */
-(void)setFindVCLeftBarButtonItemWithTitle:(NSString *)title withImageNamed:(NSString *)imageNamed withTarget:(id)target action:(SEL)buttonAction
{
    self.leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftItem.frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    self.leftItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
    self.leftItem.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.leftItem setTitle:title forState:UIControlStateNormal];
    [self.leftItem setTitleColor:[UIColor colorWithHexString:@"#50C9DD"] forState:UIControlStateNormal];
    [self.leftItem setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    
    CGFloat imageWidth = self.leftItem.imageView.bounds.size.width;
    CGFloat labelWidth = self.leftItem.titleLabel.bounds.size.width;
    self.leftItem.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    self.leftItem.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    
    [self.leftItem addTarget:target action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    
    self.leftCustomView = [[UIView alloc] initWithFrame:self.leftItem.frame];
    [self.leftCustomView addSubview:self.leftItem];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftCustomView];
}

/*
 设置找桩界面 leftBarButtonItem 名称
 */
-(void)setFindVCLeftBarButtonItemWithTitle:(NSString *)title
{
    [self.leftItem setTitle:title forState:UIControlStateNormal];
}

/*
 设置 NavigationBar rightBarButtonItem 的文字
 */
-(void)setNavigationRightButtonItemWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)buttonAction
{
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    [rightItem setTitle:title forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor colorWithHexString:@"#50C9DD"] forState:UIControlStateNormal];
    rightItem.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14.0f];
    rightItem.titleLabel.adjustsFontSizeToFitWidth = YES;
    [rightItem addTarget:target action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:buttonAction];
//    [rightItem setTintColor:[UIColor colorWithHexString:@"#50C9DD"]];
////    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14.0f],NSFontAttributeName, nil] forState:UIControlStateNormal];
//    NSLog(@" %@ ",self.navigationItem.rightBarButtonItem);
//    self.navigationItem.rightBarButtonItem = rightItem;
}

// 返回上一级界面
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 如果 accessToken 无效跳转至登录界面
 */
-(void)presentLoginController
{
    // 先弹出一个 alert 提醒需要登陆
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证失效,请重新登陆" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self redirectLoginController];
    }];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 跳转到登陆界面
-(void)redirectLoginController
{
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    LoginController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginController"];
    [self presentViewController:loginVC animated:YES completion:NULL];
}

-(void)dealloc
{
    
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
