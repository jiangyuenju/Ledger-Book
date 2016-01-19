//
//  ScanerVC.m
//  SuperScanner
//
//  Created by Jeans Huang on 10/19/15.
//  Copyright © 2015 gzhu. All rights reserved.
//

#import <JuheBarcode/JuheBarcode.h>
#ifndef appKeyForBarcodeData
#define appKeyForBarcodeData    @"77bcd23bc6abc4dbfc916dbe9aac6397"
#endif


#import "ScanerVC.h"
#import "ScanerView.h"
#import "FourthViewController.h"
#import "AddItemViewController.h"

@import AVFoundation;

@interface ScanerVC ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>{
    BarcodeSupplier *_mySupplier;
    Barcode *_barcodeSDK;
    
    __block BOOL _isProcessing; /*判断是否在请求中*/
    
    NSArray *_provinceArray; /*省份列表*/
    NSMutableDictionary *_allCitysDictionary; /*对应省份的城市字典*/
}


//! 加载中视图
@property (strong, nonatomic) IBOutlet UIView *loadingView;


//! 扫码区域动画视图
@property (strong, nonatomic) IBOutlet ScanerView *scanerView;



//AVFoundation
//! AV协调器
@property (strong,nonatomic) AVCaptureSession           *session;
//! 取景视图
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (strong, nonatomic) NSDictionary *infoDic;

@end

@implementation ScanerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanerView.alpha = 0;
    //设置扫描区域边长
    self.scanerView.scanAreaEdgeLength = [[UIScreen mainScreen] bounds].size.width - 2 * 50;
    _mySupplier = [BarcodeSupplier sharedSupplier];
    [_mySupplier registerBarcodeKey:appKeyForBarcodeData];//获取appkey对应的
    
    _barcodeSDK = [_mySupplier getBarcodeService];
    _isProcessing = NO;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.session){
        
        //添加镜头盖开启动画
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.type = @"cameraIrisHollowOpen";
        animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        animation.delegate = self;
        [self.view.layer addAnimation:animation forKey:@"animation"];
        
        //初始化扫码
        [self setupAVFoundation];
        
        //调整摄像头取景区域
        CGRect rect = self.view.bounds;
        rect.origin.y = self.navigationController.navigationBarHidden ? 0 : 64;
        self.previewLayer.frame = rect;
    }
}

//! 动画结束回调
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    self.loadingView.hidden = YES;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.scanerView.alpha = 1;
                     }];
}

//! 初始化扫码
- (void)setupAVFoundation{
    //创建会话
    self.session = [[AVCaptureSession alloc] init];
    
    //获取摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(input) {
        [self.session addInput:input];
    } else {
        //出错处理
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"请在手机【设置】-【隐私】-【相机】选项中，允许【%@】访问您的相机",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提醒"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [av show];
        return;
    }
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:output];
    
    //设置扫码类型
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,//条形码
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeCode128Code];
    //设置代理，在主线程刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //创建摄像头取景区域
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    if ([self.previewLayer connection].isVideoOrientationSupported)
        [self.previewLayer connection].videoOrientation = AVCaptureVideoOrientationPortrait;
    
    __weak typeof(self) weakSelf = self;
    [[NSNotificationCenter defaultCenter]addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                     object:nil
                                                      queue:[NSOperationQueue mainQueue]
                                                 usingBlock:^(NSNotification * _Nonnull note) {
                                                     if (weakSelf){
                                                         //调整扫描区域
                                                         AVCaptureMetadataOutput *output = weakSelf.session.outputs.firstObject;
                                                         output.rectOfInterest = [weakSelf.previewLayer metadataOutputRectOfInterestForRect:weakSelf.scanerView.scanAreaRect];
                                                     }
                                                 }];
    
    //开始扫码
    [self.session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    for (AVMetadataMachineReadableCodeObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self.session stopRunning];
            
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"二维码"
                                                        message:metadata.stringValue
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
            [av show];
            
            break;
        }else{
            [self.session stopRunning];
            
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"条形码"
//                                                        message:metadata.stringValue
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//            [av show];
            
            [self getBarCodeInfo:metadata.stringValue];
            break;
        }
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickBack:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


-(void) getBarCodeInfo: (NSString*) code{
    if (nil == _barcodeSDK)
    {
        NSLog(@"请先通过聚合官网申请有效的条码数据的appkey");
        return;
    }
    if (_isProcessing)
    {
        NSLog(@"条码查询请求正在进行中....");
        return ;
    }
    _isProcessing = YES;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:code, kBarcode,
                         @"1", kid, nil];
    [_barcodeSDK executeWorkWithAPI:@"juhe.barcode.products.code" method:@"GET" parameters:dic success:^(id responseObject) {
        [self presentReqResult:responseObject andCode:code];
    }failure:^(NSError *error) {
        [self presentReqResult:error andCode:code];
    }];
    
}

- (void) presentReqResult:(id)responseData andCode:(NSString*)code
{
    _isProcessing = NO;
    
    /* 对于请求到的结果进行判断与解析 */
    if ([responseData isKindOfClass:[NSError class]])
    {   // 请求不成功
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"报错"
                                                           message:[responseData description]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
    }
    else
    {   /*请求成功,获取返回值*/
        int resCode = [[responseData objectForKey:@"error_code"] intValue];
        if (resCode != 0) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:code
                                                               message:@"数据库中无此条形码记录"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            [alertView show];
        }else{
            NSDictionary *jsonresult = [responseData objectForKey:@"result"];
            NSDictionary *summary=[jsonresult objectForKey:@"summary"];
            NSString *name=[summary objectForKey:@"name"];
            NSLog(@"%@",name);
            
            NSString *interval=[summary objectForKey:@"interval"];
            NSLog(@"%@",interval);
            
            NSArray *array=[interval componentsSeparatedByString:@"~"];
            NSString *str1 = [array objectAtIndex:0];
            NSArray *array2=[str1 componentsSeparatedByString:@"￥:"];
            NSString *price= [array2 objectAtIndex:1];
            NSLog(@"%@",price);
            
            UITabBarController *tab=(UITabBarController*)self.presentingViewController;
            
            AddItemViewController *addItemVC=[tab.viewControllers objectAtIndex:1];
            addItemVC.detail=name;
            addItemVC.money=price;
            addItemVC.jump=YES;
            
            FourthViewController *fourthVC=[tab.viewControllers objectAtIndex:3];
            [fourthVC setJumpToAddItemVC];
            
            [fourthVC dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end
