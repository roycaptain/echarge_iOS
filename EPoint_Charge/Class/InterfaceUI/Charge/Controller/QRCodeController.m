//
//  QRCodeController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/9/7.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "QRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "SelectChargeController.h"
#import "ChargingController.h"
#import "SelectVoltageController.h"
#import "DurationController.h"
#import "PolyTypeController.h"

@interface QRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureSession *captureSession; // 捕捉会话
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *videoPreviewLayer; // 展示layer
@property(nonatomic,strong)UIImageView *boxView; // 扫描框
@property(nonatomic,strong)UIImageView *scanLine; // 扫描线

@property(nonatomic,assign)BOOL isReading; // 是否在扫描

@end

@implementation QRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"扫码充电"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    __weak typeof(self) weakSelf = self;
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!granted) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在iPhone的”设置-隐私-相机“选项中，允许App访问你的相机" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:NULL];
                [alertController addAction:confirmAction];
                return ;
            }
            [weakSelf initQRCode];
        });
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopRunning];
}

#pragma mark - 初始化扫描二维码相关空间及类
-(void)initQRCode
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    //初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:NULL];
    //创建媒体数据输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    //实例化捕捉会话
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input]; // 将输入流添加到会话
    [self.captureSession addOutput:output]; // 将媒体输出流添加到会话中
    //5.设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]]; // 设置输出媒体数据类型为QRCode
    // 6.实例化预览图层
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill]; // 设置预览图层填充方式
    [self.videoPreviewLayer setFrame:self.view.bounds];
    // 7. 将图层添加到预览view的图层上
    [self.view.layer addSublayer:self.videoPreviewLayer];
    // 8. 设置扫描范围
    output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    
    [self boxView];
    [self scanLine];
    [self startRunning]; // 开始扫描
}

#pragma mark - 开始扫描
-(void)startRunning
{
    if (self.captureSession) {
        self.isReading = YES;
        [self.captureSession startRunning];
        [self moveUpAndDownLine];
    }
}

-(void)stopRunning
{
    [self.captureSession stopRunning];
    [self.scanLine removeFromSuperview];
    [self.videoPreviewLayer removeFromSuperlayer];
}

// 扫描线上下移动
-(void)moveUpAndDownLine
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:3.0f animations:^{
        weakSelf.scanLine.frame = CGRectMake(weakSelf.boxView.frame.size.width * 0.1, weakSelf.boxView.frame.size.height - 8.0f, weakSelf.boxView.frame.size.width * 0.8, 3.0f);
    } completion:^(BOOL finished) {
        weakSelf.scanLine.frame =  CGRectMake(weakSelf.boxView.frame.size.width * 0.1f, 4.0f, weakSelf.boxView.frame.size.width * 0.8, 3.0f);
        [weakSelf moveUpAndDownLine];
    }];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 获取扫描结果
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    //判断是否有数据
    if (!_isReading) {
        return;
    }
    if (metadataObjects.count == 0) {
        [CustomAlertView showWithFailureMessage:@"扫码失败"];
    }
    _isReading = NO;
    [self stopRunning];
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
    NSString *result = metadataObject.stringValue;
    NSLog(@"result - %@",result);
    // 处理扫描结果
    [self handleQrcodeScan:result];
}

/*
 获取扫描结果 扫描结果如下的情况
 1.扫码直接充电
 2.扫码选枪充电
 3.扫码选电压充电
 4.扫码选电池充电
 5.扫码 选电压 选充电枪 选时间
 */
-(void)handleQrcodeScan:(NSString *)result
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixHandleQrcodeScan];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"qrCode" : result, @"clientType" : @"IOS"};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestPostWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary - %@",resultDictionary);
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] != RequestNetworkSuccess) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:action];
            [weakSelf presentViewController:alert animated:YES completion:NULL];
            return ;
        }
        NSDictionary *data = resultDictionary[@"data"];
        NSInteger type = [data[@"type"] integerValue];
        NSString *deviceSerialNum = [NSString stringWithFormat:@"%@",data[@"deviceSerialNum"]];
        NSString *childDeviceSerialNum = [NSString stringWithFormat:@"%@",data[@"childDeviceSerialNum"]];
        
        if (type == 0) { // 直接充电
            [[UserInfoManager shareInstance] saveUserStartChargeStatus:YES];
            UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
            ChargingController *chargingVC = [chargingSB instantiateViewControllerWithIdentifier:@"ChargingController"];
            [weakSelf.navigationController pushViewController:chargingVC animated:YES];
        } else if (type == 1) { // 选择充电枪充电
            UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
            SelectChargeController *selectVC = [chargingSB instantiateViewControllerWithIdentifier:@"SelectChargeController"];
            selectVC.deviceSerialNum = [deviceSerialNum mutableCopy];
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
        } else if (type == 2) { // 选择电压充电
            UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
            SelectVoltageController *selectVC = [chargingSB instantiateViewControllerWithIdentifier:@"SelectVoltageController"];
            selectVC.deviceSerialNum = [deviceSerialNum mutableCopy];
            selectVC.childDeviceSerialNum = [childDeviceSerialNum mutableCopy];
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
        } else if (type == 3) { // 选择充电枪 电压 电池 时间
            UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
            PolyTypeController *selectVC = [chargingSB instantiateViewControllerWithIdentifier:@"PolyTypeController"];
            selectVC.deviceSerialNum = [deviceSerialNum mutableCopy];
            selectVC.type = type;
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
            
        } else if (type == 4) { // 选择充电时长
            
            UIStoryboard *chargingSB = [UIStoryboard storyboardWithName:@"Charge" bundle:[NSBundle mainBundle]];
            DurationController *selectVC = [chargingSB instantiateViewControllerWithIdentifier:@"DurationController"];
            [weakSelf.navigationController pushViewController:selectVC animated:YES];
            
        } else {
            [CustomAlertView showWithFailureMessage:@"暂不支持该类型充电"];
        }
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

-(void)dealloc
{
    self.captureSession = nil;
    self.videoPreviewLayer = nil;
}

#pragma mark - lazy load
-(UIImageView *)boxView
{
    if (!_boxView) {
        _boxView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.2f, self.view.frame.size.height * 0.3f, self.view.frame.size.width - self.view.frame.size.width * 0.4f, self.view.frame.size.width - self.view.frame.size.width * 0.4f)];
        _boxView.image = [UIImage imageNamed:@"scan_layer"];
        _boxView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_boxView];
    }
    return _boxView;
}

-(UIImageView *)scanLine
{
    if (!_scanLine) {
        _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(_boxView.frame.size.width * 0.1, 4.0f, _boxView.frame.size.width * 0.8, 3.0f)];
        _scanLine.image = [UIImage imageNamed:@"scan_line"];
        [self.boxView addSubview:_scanLine];
    }
    return _scanLine;
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
