//
//  ShareListViewController.m
//  hbbciphone
//
//  Created by Handbbc on 2017/7/10.
//  Copyright © 2017年 hbbc. All rights reserved.
//

#import "ShareListViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "ShareCodeToOpenViewController.h"
#import "ShareAnnotation.h"
#import "UserInforViewController.h"
#import "CustomView.h"
#import "ShareSearchViewController.h"
#import "ChargeInViewController.h"
#import "RegistViewController.h"
#import "CertainViewController.h"
#import "CommonUtility.h"
#import "MANaviRoute.h"
#import "MANaviPolyline.h"
#import "LineDashPolyline.h"
#import "GoodsDetailViewController.h"

@interface ShareListViewController ()<AMapSearchDelegate,MAMapViewDelegate,AMapLocationManagerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>{
    
}
//自动登录秘钥
@property (nonatomic,strong)NSString *autoLoginKey;
//注册的电话号码
@property (nonatomic,strong)NSString *phoneNumber;
//所需支付押金数额
@property (nonatomic,strong)NSString *PayDespositNum;
//是否注册登录
@property (nonatomic,assign)BOOL isLogin;
//是否需要实名认证
@property (nonatomic,assign)BOOL isCertain;
//是否需要交纳押金
@property (nonatomic,assign)BOOL isPayCharge;

@property(nonatomic,strong)MAMapView *mapView;
@property (nonatomic, strong) AMapRoute *route;//路径规划信息
@property (strong, nonatomic) MANaviRoute * naviRoute;  //用于显示当前路线方案.
@property (assign, nonatomic) NSUInteger totalRouteNums;  //总共规划的线路的条数
@property (assign, nonatomic) NSUInteger currentRouteIndex; //当前显示线路的索引值，从0开始
@property (nonatomic, strong) AMapLocationManager *locationManger;
@property(nonatomic,strong) CustomView *Cview;
@property (nonatomic,strong)NSString *testID;  //搜索页传回来的地址
@property (nonatomic,retain)AMapSearchAPI *search;



@property (nonatomic,strong)CLGeocoder *geocoder;

@property (nonatomic)CLLocation *alocation;

@property (nonatomic)CLLocationCoordinate2D Location;
@property(nonatomic)CLLocationCoordinate2D annotationLocation;

@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;

@property (nonatomic,strong)NSString *myLocation;

@property (nonatomic,strong)NSArray *goodsArr;

@property (nonatomic,strong)NSMutableArray *annotationArr;

@property (nonatomic,strong)ShareSearchViewController *ssvc;
@property (nonatomic,strong)GoodsDetailViewController *gdvc;
@property (nonatomic,strong)NSString *goodSNID; //从详情页传回来的物品编号



@end

@implementation ShareListViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
       return UIStatusBarStyleLightContent;
   // return UIStatusBarStyleDefault;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(66, 165, 234);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self test];
    [self ifLookPath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AMapServices sharedServices].apiKey = gaodeKey;
    self.title = @"共享公寓";
    [self.view insertSubview:self.mapView atIndex:0];
    [self ifLogin];
    [self initUI];
    [self setNaviBar];
    //    自定义用户位置图标
    [self ShowUserLocationRepresation];
    
    [self buttonToOpen];
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCview) name:@"alerdyLogin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTheCview) name:@"exitLogin" object:nil];
}
//登录后的通知事件
-(void)changeCview
{
    [_Cview mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.left.right.equalTo(0);
         make.top.equalTo(64);
         make.height.equalTo(140);
     }];
    _Cview.registBtn.hidden = YES;
    _isLogin = YES;
    _isCertain = YES;
    _isPayCharge = YES;
}

//退出登录后的通知事件
-(void)changeTheCview
{
    [_Cview mas_remakeConstraints:^(MASConstraintMaker *make)
     {
         make.left.right.equalTo(0);
         make.top.equalTo(64);
         make.height.equalTo(190);
     }];
    _Cview.registBtn.hidden = NO;
    _isLogin = NO;
    _isCertain = YES;
    _isPayCharge = YES;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"UserAutoLoginKey"];
}

-(void)ifLogin
{
    if(PhoneNum == nil)
    {
        _phoneNumber = @"";
        _autoLoginKey = @"";
    }
    else
    {
        _phoneNumber = PhoneNum;
        _autoLoginKey = UserAutoLoginKey;
    }
    NSDictionary *parameters = @{
                                 @"ECID":ECID,
                                 @"PhoneNumber":_phoneNumber,
                                 @"TempVerifyCode":@"",
                                 @"AppType":@"2",
                                 @"AutoLoginKey":_autoLoginKey,
                                 @"AppID":APPID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:DOLOGIN success:^(id responseBody){DHResponseBodyLog(responseBody);
        NSLog(@"%@",responseBody[@"Notice"]);
        if ([responseBody[@"Notice"] isEqualToString:@"操作成功"])
        {
            self.title = responseBody[@"AppName"];
            _isLogin = YES;
            NSString * openCertification = [NSString stringWithFormat:@"%@",responseBody[@"OpenCertification"]];
            NSString * OpenDesposit = [NSString stringWithFormat:@"%@",responseBody[@"OpenDesposit"]];
            NSString * CertificationStatus = [NSString stringWithFormat:@"%@",responseBody[@"CertificationStatus"]];
            NSString *DespositStatus = [NSString stringWithFormat:@"%@",responseBody[@"DespositStatus"]];
            _PayDespositNum = [NSString stringWithFormat:@"%@",responseBody[@"PayDespositNum"]];
            // 是否需要实名认证
            if ([openCertification isEqualToString:@"1"])
            {
                // 实名认证是否通过
                if ([CertificationStatus isEqualToString:@"1"])
                {
                    _isCertain = YES;
                    //是否需要开启押金
                    if ([OpenDesposit isEqualToString:@"1"])
                    {
                        //交纳押金状态
                        if ([DespositStatus isEqualToString:@"1"])
                        {
                            _isPayCharge = NO;
                        }
                        else
                        {
                            _isPayCharge = YES;
                        }
                    }
                    else
                    {
                        _isPayCharge = YES;
                    }
                }
                else
                {
                    _isCertain = NO;
                }
            }
        }
        else
        {
            _isLogin = NO;
        }
        
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

- (NSArray *)goodsArr
{
    if (!_goodsArr)
    {
        _goodsArr = [NSArray array];
    }
    return _goodsArr;
}

- (NSMutableArray *)annotationArr
{
    if (!_annotationArr)
    {
        _annotationArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _annotationArr;
}


-(MAPointAnnotation*)startAnnotation
{
    if (!_startAnnotation)
    {
        _startAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _startAnnotation;
}

-(MAPointAnnotation*)destinationAnnotation
{
    if (!_destinationAnnotation)
    {
        _destinationAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _destinationAnnotation;
}

#pragma mark 判断是否是从详情页跳回来
-(void)ifLookPath
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTheEndPlace:) name:@"getTheSNID" object:nil];
}

#pragma mark 判断是否是从搜索页跳回来
-(void)test
{
    _ssvc = [[ShareSearchViewController alloc]init];
    __weak typeof (self)weakself = self;
    _ssvc.aBlock = ^(NSString *address)
    {
        weakself.testID = address;
    };
    
    if ([_testID  isEqual: @""] || _testID == nil)
    {
        return;
    }
    
    else
    {
        //移除地图原本的遮盖
        [self.naviRoute removeFromMapView];
        [_mapView setZoomLevel:16.0 animated:YES];
        _geocoder = [[CLGeocoder alloc]init];
        [_geocoder geocodeAddressString:_testID completionHandler:^(NSArray *placemarks, NSError *error)
         {
             // 地理编码,取得第一个地标,一个地名可能搜出多个地址(placemark为数组)
             CLPlacemark *placemark = [placemarks firstObject];
             self.mapView.centerCoordinate = placemark.location.coordinate;
             
             NSString *lat = [NSString stringWithFormat:@"%f",
                              placemark.location.coordinate.latitude];
             NSString *lng = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
             //调取附近物品信息接口
             NSDictionary *parameters = @{
                                          @"ECID":ECID,
                                          @"Lat":lat,
                                          @"Lng":lng,
                                          @"AppID":APPID
                                          };
             [[NetworkSingleton shareManager] httpRequest:parameters url:GETALLITEMS success:^(id responseBody){DHResponseBodyLog(responseBody);
                 NSLog(@"%@",responseBody[@"Notice"]);
                 self.goodsArr = [NSArray arrayWithArray:responseBody[@"GoodsList"]];
                 [self initAnnotation];
             } failed:^(NSError *error)
              {
                  DHErrorLog(error);
              }];
             
         }];
        
    }
}

//将物品详情传回来的物品作为终点
-(void)setTheEndPlace:(NSNotification *)notification
{
    for (int i = 0; i < _goodsArr.count; i++) {
        NSString *SNID = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"GoodsSNID"]];
        if ([SNID isEqualToString:notification.object]) {
            MAPointAnnotation *a = [[MAPointAnnotation alloc]init];
            a = _annotationArr[i];
            self.startAnnotation.coordinate = _Location;
            self.destinationAnnotation.coordinate = a.coordinate;
            [self setWalkRouteParameter];
        }
    }
}

-(MAMapView *)mapView
{
    if (!_mapView)
    {
        //需要手动配置info.plist进行定位
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mapView.delegate = self;
        //    NO为不显示指南针
        _mapView.showsCompass = NO;
        //设置成NO表示不显示比例尺；YES表示显示比例尺
        _mapView.showsScale = YES;
        //    设置定位距离
        _mapView.distanceFilter = 10.0f;
        //    缩放等级
        _mapView.zoomLevel = 16;
        //    设置定位精度
        _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        //    设置地图类型
        _mapView.mapType = MAMapTypeStandard;
        
    }
    return _mapView;
}



-(void)initUI
{
    _SmallLocationIcon = [[UIImageView alloc]init];
    [_SmallLocationIcon setImage:[UIImage imageNamed:@"coding"]];
    [self.view addSubview:_SmallLocationIcon];
    [_SmallLocationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_centerY);
        make.width.height.equalTo(25);
    }];
    
    _locationManger = [[AMapLocationManager alloc] init];
    _locationManger.delegate = self;
    //       定位超时时间，最低2s
    _locationManger.locationTimeout = 2;
    //       逆地理请求超时时间，最低2s，此处设置为10s
    _locationManger.reGeocodeTimeout = 2;
    [self locationTo];
}

-(void)setNaviBar
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAPPName:) name:@"getAppName" object:nil];
    UIButton *btnRight =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    [btnRight addTarget:self action:@selector(goToSearch) forControlEvents:UIControlEventTouchUpInside];
    [btnRight setImage:[UIImage imageNamed:@"mshare_search"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:btnRight ];
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 20, 20)];
    [backImg setImage:[UIImage imageNamed:@"mshare_menu"]];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [backBtn addTarget:self action:@selector(UserInfor) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImg];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

#pragma mark 显示导航栏标题
-(void)showAPPName:(NSNotification *)notification
{
    self.title = notification.userInfo[@"APPName"];
}

/*设置步行路径*/

-(void)setWalkRouteParameter
{
    [self.mapView addAnnotation:self.startAnnotation];
    self.startAnnotation.title = @"起点";
    AMapWalkingRouteSearchRequest *request = [[AMapWalkingRouteSearchRequest alloc]init];
    request.origin = [AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude  ];
    request.destination = [AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude ];
    [_search AMapWalkingRouteSearch:request];
}

#pragma mark - AMapSearchDelegate

//路径规划搜索完成回调.
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    
    if (response.route == nil){
        return;
    }
    
    self.route = response.route;
    self.totalRouteNums = self.route.paths.count;
    self.currentRouteIndex = 0;
    [self presentCurrentRouteCourse];
}

//在地图上显示当前选择的路径
- (void)presentCurrentRouteCourse {
    
    if (self.totalRouteNums <= 0) {
        return;
    }
    
    [self.naviRoute removeFromMapView];  //清空地图上已有的路线
    
    MANaviAnnotationType type = MANaviAnnotationTypeWalking; //走路类型
    
    AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude]; //起点
    
    AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude];  //终点
    
    //根据已经规划的路径，起点，终点，规划类型，是否显示实时路况，生成显示方案
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentRouteIndex] withNaviType:type showTraffic:NO startPoint:startPoint endPoint:endPoint];
    
    [self.naviRoute addToMapView:self.mapView];  //显示到地图上
    
    UIEdgeInsets edgePaddingRect = UIEdgeInsetsMake(20, 20, 20, 20);
    
    //缩放地图使其适应polylines的展示
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:edgePaddingRect
                           animated:YES];
}

#pragma mark - MAMapViewDelegate

//地图上覆盖物的渲染，可以设置路径线路的宽度，颜色等
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    
    //虚线，如需要在建筑物内步行的
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth = 6;
        //        polylineRenderer.lineDash = YES;
        polylineRenderer.strokeColor = RGBCOLOR(66, 165, 234);
        
        return polylineRenderer;
    }
    
    //showTraffic为NO时，不需要带实时路况，路径为单一颜色
    if ([overlay isKindOfClass:[MANaviPolyline class]]) {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        polylineRenderer.lineWidth = 6;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking) {
            polylineRenderer.strokeColor = RGBCOLOR(66, 165, 234);
        } else if (naviPolyline.type == MANaviAnnotationTypeRailway) {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        } else {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    
    return nil;
}




#pragma mark 用户信息
-(void)UserInfor{
    if (_isLogin && _isCertain &&  _isPayCharge)
    {
        UserInforViewController *v =[[UserInforViewController alloc]init];
        [self.navigationController pushViewController:v animated:YES];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"请先注册登录并交纳押金" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            RegistViewController *rvc = [[RegistViewController alloc]init];
            [self.navigationController pushViewController:rvc animated:YES];
        }];
        
        [alertController addAction:ensureAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark 搜索
-(void)goToSearch{
    if (_isLogin && _isCertain &&  _isPayCharge)
    {
        _ssvc.myLocation = _myLocation;
        [self.navigationController pushViewController:_ssvc animated:YES];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"请先注册登录并交纳押金" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            RegistViewController *rvc = [[RegistViewController alloc]init];
            [self.navigationController pushViewController:rvc animated:YES];
        }];
        
        [alertController addAction:ensureAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark  扫码预约
-(void)QRCodeBtOnClick
{
    if (_isLogin && _isCertain &&  _isPayCharge)
    {
        ShareCodeToOpenViewController *v =[[ShareCodeToOpenViewController alloc]init];
        [self.navigationController pushViewController:v animated:YES];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"亲" message:@"注册登录并交纳押金后才可使用" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            RegistViewController *rvc = [[RegistViewController alloc]init];
            [self.navigationController pushViewController:rvc animated:YES];
        }];
        [alertController addAction:ensureAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark 点击定位按钮
-(void)locationTo
{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    [_mapView setZoomLevel:16.0 animated:YES];
    [_locationManger requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        _Location = location.coordinate;
        //根据当前位置经纬度进行位置反编码，来获取位置的详细信息
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        _alocation = [[CLLocation alloc] initWithLatitude:_Location.latitude longitude:_Location.longitude];
        [geocoder reverseGeocodeLocation:_alocation completionHandler:^(NSArray *placemarks,NSError *error){
            for(CLPlacemark *placemark in placemarks)
            {
                _myLocation = [NSString stringWithFormat:@"%@%@%@",placemark.locality,placemark.subLocality,placemark.name];
            }
        }];
        [_mapView setCenterCoordinate:_Location animated:YES];
        _testID = nil;
        NSString *lat = [NSString stringWithFormat:@"%f",
                         _Location.latitude];
        NSString *lng = [NSString stringWithFormat:@"%f",_Location.longitude];
        //调取附近物品信息接口
        NSDictionary *parameters = @{
                                     @"ECID":ECID,
                                     @"Lat":lat,
                                     @"Lng":lng,
                                     @"AppID":APPID
                                     };
        [[NetworkSingleton shareManager] httpRequest:parameters url:GETALLITEMS success:^(id responseBody){DHResponseBodyLog(responseBody);
            NSLog(@"%@",responseBody[@"Notice"]);
            self.goodsArr = [NSArray arrayWithArray:responseBody[@"GoodsList"]];
            [self initAnnotation];
        } failed:^(NSError *error)
         {
             DHErrorLog(error);
         }];
    }];
}

//获取附近商品信息
-(void)initAnnotation
{
    [self.mapView removeAnnotations:_annotationArr];
    [_annotationArr removeAllObjects];
    for (int i = 0; i < _goodsArr.count; i++)
    {
        NSDictionary *dic = _goodsArr[i];
        _annotationLocation.latitude = [[dic objectForKey:@"Lat"] doubleValue];
        _annotationLocation.longitude = [[dic objectForKey:@"Lng"] doubleValue];
        MAPointAnnotation *a = [[MAPointAnnotation alloc]init];
        a.coordinate = _annotationLocation;
        [self.annotationArr addObject:a];
    }
    [self.mapView addAnnotations:_annotationArr];
}

#pragma mark 显示用户当前位置的图标
-(void)ShowUserLocationRepresation{
    
    MAUserLocationRepresentation *LP = [[MAUserLocationRepresentation alloc]init];
    LP.showsAccuracyRing = NO;
    LP.showsHeadingIndicator = YES;
    [self.mapView updateUserLocationRepresentation:LP];
    
}


#pragma mark --自定义大头针图形
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        return nil;
    }
    static NSString *reuseID = @"AnnotaionReuseIdentifier";
    ShareAnnotation *Anno =(ShareAnnotation *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if (Anno == nil) {
        Anno = [[ShareAnnotation alloc]initWithAnnotation:annotation reuseIdentifier:reuseID];
        Anno.centerOffset = CGPointMake(0, -25);
    }
    //如果是起点
    if([annotation.title isEqualToString:@"起点"])
    {
        Anno.portraitImageView.image = [UIImage imageNamed:@"startPoint"];
        Anno.portraitImageView.frame = CGRectMake(12, 25, 25, 25);
        Anno.portraitImageView.layer.cornerRadius = 0;
    }
    //如果是中间的拐点
    else if ([annotation isKindOfClass:[MANaviAnnotation class]])
    {
        Anno.portraitImageView.image = nil;
    }
    //如果是地图上的物品点
    else
    {
        for (int i = 0; i < _goodsArr.count; i++)
        {
            if(annotation == _annotationArr[i])
            {
                Anno.portraitImageView.image = [UIImage imageNamed:@"986291AACF2E8BED6F7E00241278372D"];
                [Anno.portraitImageView sd_setImageWithURL:[NSURL URLWithString:[_goodsArr[i] objectForKey:@"GoodsTypePicFileID"]] placeholderImage:[UIImage imageNamed:@"datouzheng"]];
            }
        }
    }
    return Anno;
}


#pragma mark - MAMapViewDelegate（点击一个大头针时的事件）

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    [self.naviRoute removeFromMapView];
    for (int i = 0; i < _goodsArr.count; i++)
    {
        if (view.annotation == _annotationArr[i])
        {
            if(_isLogin == NO || _isCertain == NO || _isPayCharge == NO)
            {
                _Cview = [[CustomView alloc]init];
                [self.view addSubview: _Cview];
                [_Cview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(0);
                    make.top.equalTo(64);
                    make.height.equalTo(190);
                }];
            }
            else
            {
                _Cview = [[CustomView alloc]init];
                [self.view addSubview: _Cview];
                [_Cview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(0);
                    make.top.equalTo(64);
                    make.height.equalTo(140);
                }];
                _Cview.registBtn.hidden = YES;
            }
            UISwipeGestureRecognizer * panGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                        action:@selector(doHandlePanAction:)];
            panGestureRecognizer.cancelsTouchesInView = NO;
            [panGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
            [_Cview addGestureRecognizer:panGestureRecognizer];
            
            _Cview.numberLabel.text = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"GoodsSNID"]];
            _Cview.kindLabel.text = [_goodsArr[i] objectForKey:@"GoodsName"];
            NSString * x = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"BusinessType"]];
            if ([x isEqual: @"1"])
            {
                _Cview.typeLabel.text = @"付押金使用";
            }
            else
            {
                _Cview.typeLabel.text = @"扫码预约";
            }
            _Cview.payLabel.text = [NSString stringWithFormat:@"%@元",[_goodsArr[i] objectForKey:@"GoodsDeposit"]];
            [_Cview.imgView sd_setImageWithURL:[NSURL URLWithString:[_goodsArr[i] objectForKey:@"GoodsPic"]]];
            _Cview.moneyLabel.text = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"GoodsUsePrice"]];
            
            MAPointAnnotation *a = [[MAPointAnnotation alloc]init];
            a = _annotationArr[i];
            CLLocation * theLocation = [[CLLocation alloc]initWithLatitude:a.coordinate.latitude longitude:a.coordinate.longitude];
            //根据大头针位置经纬度进行位置反编码，来获取位置的详细信息
            CLGeocoder *geocoder = [[CLGeocoder alloc]init];
            [geocoder reverseGeocodeLocation:theLocation completionHandler:^(NSArray *placemarks,NSError *error){
                for(CLPlacemark *placemark in placemarks)
                {
                    _Cview.label.text = [NSString stringWithFormat:@"%@%@%@",placemark.locality,placemark.subLocality,placemark.name];
                }
            }];
            if ([_testID  isEqual: @""] || _testID == nil)
            {
                self.startAnnotation.coordinate = _Location;
                self.destinationAnnotation.coordinate = a.coordinate;
                
                MAMapPoint start = MAMapPointForCoordinate(CLLocationCoordinate2DMake(_startAnnotation.coordinate.latitude, _startAnnotation.coordinate.longitude));
                MAMapPoint end = MAMapPointForCoordinate(CLLocationCoordinate2DMake(_destinationAnnotation.coordinate.latitude, _destinationAnnotation.coordinate.longitude));
                CLLocationDistance distance = MAMetersBetweenMapPoints(start, end);
                NSString *dis = [NSString stringWithFormat:@"%f",distance];
                NSArray *strArr = [dis componentsSeparatedByString:@"."];
                _Cview.metreLabel.text = strArr[0];
                
                int walkTime = [_Cview.metreLabel.text intValue] / 80 + 1;
                _Cview.timeLabel.text = [NSString stringWithFormat:@"%d",walkTime];
                
                [self setWalkRouteParameter];
            }
            else
            {
                _geocoder = [[CLGeocoder alloc]init];
                [_geocoder geocodeAddressString:_testID completionHandler:^(NSArray *placemarks, NSError *error)
                 {
                     // 地理编码,取得第一个地标,一个地名可能搜出多个地址(placemark为数组)
                     CLPlacemark *placemark = [placemarks firstObject];
                     self.mapView.centerCoordinate = placemark.location.coordinate;
                     self.startAnnotation.coordinate = placemark.location.coordinate;
                     self.destinationAnnotation.coordinate = a.coordinate;
                     
                     MAMapPoint start = MAMapPointForCoordinate(CLLocationCoordinate2DMake(_startAnnotation.coordinate.latitude, _startAnnotation.coordinate.longitude));
                     MAMapPoint end = MAMapPointForCoordinate(CLLocationCoordinate2DMake(_destinationAnnotation.coordinate.latitude, _destinationAnnotation.coordinate.longitude));
                     CLLocationDistance distance = MAMetersBetweenMapPoints(start, end);
                     NSString *dis = [NSString stringWithFormat:@"%f",distance];
                     NSArray *strArr = [dis componentsSeparatedByString:@"."];
                     _Cview.metreLabel.text = strArr[0];
                     
                     int walkTime = [_Cview.metreLabel.text intValue] / 80 + 1;
                     _Cview.timeLabel.text = [NSString stringWithFormat:@"%d",walkTime];
                     [self.view addSubview: _Cview];
                     [self setWalkRouteParameter];
                 }];
            }
        }
        else
        {
        }
    }
    
    __weak typeof (self)weakself = self;
    _Cview.theBlock = ^(){
        
        RegistViewController *rvc = [[RegistViewController alloc]init];
        [weakself.navigationController pushViewController:rvc animated:YES];
        
    };
    
}
#pragma mark 上方view滑动响应
- (void) doHandlePanAction:(UIGestureRecognizer *)panGestureRecognizer
{
    [CustomView animateWithDuration:0.6 animations:^{_Cview.frame = CGRectMake(0,  - 126, SCREEN_WIDTH  , 0);}];
    [self performSelector:@selector(removeTheCView) withObject:nil afterDelay:0.8];
    [self.naviRoute removeFromMapView];  //清空地图上已有的路线
}

-(void)removeTheCView
{
    [_Cview removeFromSuperview];
}


#pragma mark 点击大头针以外的地方
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    [_Cview removeFromSuperview];
    [self.naviRoute removeFromMapView];
}

//缩放按钮视图
- (UIView *)makeZoomPannelView
{
    UIView *ret = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 98)];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    
    return ret;
}

- (void)zoomPlusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}

#pragma mark buttonToOpen

-(void)buttonToOpen
{
    //左边定位按钮
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locationBtn.backgroundColor = [UIColor whiteColor];
    [locationBtn setImage:[UIImage imageNamed:@"gpsStat2"] forState:UIControlStateNormal];
    locationBtn.layer.cornerRadius = 20;
    [self.view addSubview:locationBtn];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-30);
        make.left.equalTo(10);
        make.width.height.equalTo(40);
    }];
    [locationBtn addTarget:self action:@selector(locationTo) forControlEvents:UIControlEventTouchUpInside];
    //    创建底层button
    UIButton *QRcodeBt =[[UIButton alloc]init];
    [QRcodeBt setBackgroundColor:RGBCOLOR(66, 165, 234)];
    QRcodeBt.layer.cornerRadius =20;
    QRcodeBt.clipsToBounds=YES;
    QRcodeBt.layer.borderColor=RGBCOLOR(66, 165, 234).CGColor;
    QRcodeBt.layer.borderWidth=1;
    [self.mapView addSubview:QRcodeBt];
    
    UIView *zoomPannelView = [self makeZoomPannelView];
    [self.view addSubview:zoomPannelView];
    [zoomPannelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.bottom.equalTo(-10);
        make.width.equalTo(53);
        make.height.equalTo(98);
    }];
    
    
    //创建label ，上面图层
    UIImageView *IconScan = [[UIImageView alloc]init];
    IconScan.image=[UIImage imageNamed:@"mshare_scan"];
    
    UILabel *labelT = [[UILabel alloc]init];
    labelT.text = @"扫码预约";
    labelT.font=[UIFont systemFontOfSize:13];
    labelT.textColor=[UIColor whiteColor];
    
    [QRcodeBt addSubview:IconScan];
    [QRcodeBt addSubview:labelT];
    [QRcodeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mapView.bottom).offset(-20);
        make.centerX.equalTo(self.mapView.centerX);
        make.height.equalTo(40);
        make.width.equalTo(120);
    }];
    
    [IconScan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(QRcodeBt.left).offset(18);
        make.centerY.equalTo(QRcodeBt.centerY);
        make.height.equalTo(15);
        make.width.equalTo(15);
    }];
    
    [labelT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IconScan.right).offset(10);
        make.centerY.equalTo(QRcodeBt.centerY);
        make.height.equalTo(30);
        make.width.equalTo(80);
    }];
    
    [QRcodeBt addTarget:self action:@selector(QRCodeBtOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapView addSubview:QRcodeBt];
}

@end
