//
//  ShareCodeToOpenViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/17.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ShareCodeToOpenViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HBManalLockController.h"
#import "ProgressViewController.h"
#import "GoodsDetailViewController.h"

/**
 *  屏幕 高 宽 边界
 */
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds

#define TOP 190
#define LEFT (SCREEN_WIDTH-220)/2

#define kScanRect CGRectMake(LEFT, TOP, 220, 220)

@interface ShareCodeToOpenViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic,strong)NSString *stringValue;

@property (nonatomic, strong) UIImageView * line;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@property (weak, nonatomic) IBOutlet UILabel *labelInput;
@property (weak, nonatomic) IBOutlet UIButton *numberInputBtn;

@property (weak, nonatomic) IBOutlet UIButton *lightopenBtn;
@property (weak, nonatomic) IBOutlet UILabel *LightLabel;

@end

@implementation ShareCodeToOpenViewController
#pragma mark UI

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initOtherUI];
    [self configView];
    [self setupMaskView];
    [self lightOpenAndCircleButton];
}

-(void)configView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    [self setCropRect:kScanRect];
    
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [_session startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}


- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    [cropLayer setNeedsDisplay];
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/SCREEN_HEIGHT;
    CGFloat left = LEFT/SCREEN_WIDTH;
    CGFloat width = 220/SCREEN_WIDTH;
    CGFloat height = 220/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        _stringValue = metadataObject.stringValue;
        [self queryBtOnClick];
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}

#pragma mark-> 确定
-(void)queryBtOnClick
{
    [CommonClass showMBProgressHUD:nil andWhereView:self.view];
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"GoodsSNID":_stringValue,
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:USERITEMDETAIL success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        [CommonClass hideMBprogressHUD:self.view];
        NSString *status = [NSString stringWithFormat:@"%@",responseBody[@"Status"]];
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            //使用中
            if ([status isEqual:@"2"])
            {
                ProgressViewController *dfc = [[ProgressViewController alloc]init];
                dfc.carNumber = _stringValue;
                dfc.resPonsbody = responseBody;
                [self.navigationController pushViewController:dfc animated:YES];
            }
            //待使用
            else if([status isEqual:@"1"])
            {
                GoodsDetailViewController *gdc = [[GoodsDetailViewController alloc]init];
                gdc.carNumber = _stringValue;
                gdc.resPonsbody = responseBody;
                [self.navigationController pushViewController:gdc animated:YES];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"该物品正在审核中" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            if ([status isEqual:@"2"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"该物品他人正在使用中" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"请保证输入正确的物品编号" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:OKAction];
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
            }
        }
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
    
}

-(void)initOtherUI{
    UIButton  *Titlebutton =[[UIButton alloc]init];
    [self.view  addSubview:Titlebutton];
    
    [Titlebutton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];
    UIImageView *imgLeft = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 25, 25)];
    [imgLeft setImage:[UIImage imageNamed:@"sharenavigation_back"]];
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 30, 80, 25)];
    [btnLeft addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft addSubview:imgLeft];
    [self.view addSubview:btnLeft];
    
    [Titlebutton setTitle:@"物品扫码" forState:UIControlStateNormal];
    Titlebutton.titleLabel.font =[UIFont systemFontOfSize:18];
    [Titlebutton setTitleEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    [Titlebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImageView *imgview = [[UIImageView alloc]init];
    [imgview setImage:[UIImage imageNamed:@"thelogo"]];
    [self.view addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Titlebutton.bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(220);
        make.height.equalTo(120);
    }];
}

-(void)lightOpenAndCircleButton{
    self.lightopenBtn.layer.cornerRadius=self.lightopenBtn.bounds.size.width/2;
    self.lightopenBtn.clipsToBounds=YES;
    self.lightopenBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.lightopenBtn.backgroundColor=[UIColor lightGrayColor];
    self.lightopenBtn.layer.borderWidth=1;
    
    self.numberInputBtn.layer.cornerRadius=self.numberInputBtn.bounds.size.width/2;
    self.numberInputBtn.clipsToBounds=YES;
    self.numberInputBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.numberInputBtn.backgroundColor=[UIColor lightGrayColor];
    self.numberInputBtn.layer.borderWidth=1;
    
    [_numberInputBtn addTarget:self action:@selector(inputNumber) forControlEvents:UIControlEventTouchUpInside];
    
    [_lightopenBtn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:self.numberInputBtn];
    [self.view bringSubviewToFront:self.lightopenBtn];
    [self.view bringSubviewToFront:self.labelInput];
    [self.view bringSubviewToFront:self.LightLabel];
}



- (void)setupMaskView
{
    //设置底层的黑色的图
    UIView *BottomViews  =[[UIImageView alloc]init];
    [self.view addSubview:BottomViews];
    
    [BottomViews  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.height.equalTo(100);
    }];
    BottomViews.backgroundColor=[UIColor blackColor];
}

#pragma mark闪光灯
-(void)openFlash:(UIButton*)button{
    
    button.selected = !button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }
    else{
        [self turnTorchOn:NO];
    }
}
#pragma mark开关闪光灯
- (void)turnTorchOn:(BOOL)on
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}


#pragma  mark Actions
-(void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)inputNumber{
    [_session stopRunning];
    
    HBManalLockController *manualLock =[[HBManalLockController alloc]init];
    ;
    [self.navigationController pushViewController:manualLock animated:YES];
    
}

@end
