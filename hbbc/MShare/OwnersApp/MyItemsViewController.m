//
//  MyItemsViewController.m
//  sdsjOwnerApp
//
//  Created by Handbbc on 2017/8/22.
//  Copyright © 2017年 xushaodong. All rights reserved.
//

#import "MyItemsViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "ShareAnnotation.h"
#import "CustomView.h"
#import "MyItemsView.h"
#import "EditItemViewController.h"


@interface MyItemsViewController ()<MAMapViewDelegate,AMapSearchDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIButton *btnRight;
@property(nonatomic,strong)MAMapView *mapView;
@property (nonatomic,retain)AMapSearchAPI *search;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property(nonatomic,strong) MyItemsView *Cview;
@property (nonatomic, strong) AMapRoute *route;
@property (nonatomic,retain)NSArray *pathPolylines;
@property (nonatomic,strong)CLGeocoder *geocoder;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;

@property (nonatomic)CLLocation *alocation;

@property (nonatomic)CLLocationCoordinate2D Location;
@property(nonatomic)CLLocationCoordinate2D annotationLocation;

@property (nonatomic,strong)NSString *myLocation;

@property (nonatomic,strong)NSArray *goodsArr;

@property (nonatomic,strong)NSMutableArray *annotationArr;
@property (nonatomic,strong)NSMutableArray *mutableAnnotationArr;


@end

@implementation MyItemsViewController

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

- (NSArray *)pathPolylines
{
    if (!_pathPolylines)
    {
        _pathPolylines = [NSArray array];
    }
    return _pathPolylines;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//            [CommonClass showMBProgressHUD:@"加载中" andWhereView:self.view];
    self.title = @"我的物品";
    UIButton *btnLeft =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [btnLeft setImage:[UIImage imageNamed:@"sharenavigation_back"] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btnLeft];
    
    _btnRight = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    [_btnRight addTarget:self action:@selector(editItems) forControlEvents:UIControlEventTouchUpInside];
    [_btnRight setTitle:@"编辑" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_btnRight];
    _btnRight.enabled = NO;
    
    [AMapServices sharedServices].apiKey = kGaoDeMap;
    
    [self.view insertSubview:self.mapView atIndex:0];
    [self initUI];
    //    自定义用户位置图标
    [self ShowUserLocationRepresation];
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    //调取我的物品信息接口
    NSDictionary *parameters = @{
                                 @"ECID":OwnerECID,
                                 @"PhoneNumber":@"15093337480",
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:GETMYITEMS success:^(id responseBody){DHResponseBodyLog(responseBody);
        NSLog(@"%@",responseBody[@"Notice"]);
        self.goodsArr = [NSArray arrayWithArray:responseBody[@"GoodsList"]];
        [self initAnnotation];
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
    [self buttonToOpen];
}
-(MAMapView *)mapView
{
    if (!_mapView)
    {
        //需要手动配置info.plist进行定位
        _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SCREEN_HEIGHT)];
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
    [self locationTo];
}
#pragma mark 点击定位按钮
-(void)locationTo
{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

//获取我的物品信息
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
    if([annotation isKindOfClass:[MAPointAnnotation class]]){
        
        ShareAnnotation *Anno =(ShareAnnotation *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
        if (Anno == nil)
        {
            Anno = [[ShareAnnotation alloc]initWithAnnotation:annotation reuseIdentifier:reuseID];
            Anno.centerOffset = CGPointMake(0, -25);
            
        }
        for (int i = 0; i < _goodsArr.count; i++)
        {
            [Anno.portraitImageView sd_setImageWithURL:[NSURL URLWithString:[_goodsArr[i] objectForKey:@"GoodsTypePicFileID"]] placeholderImage:[UIImage imageNamed:@"mshare_excavator"]];
        }
        return Anno;
    }
    return nil;
    
}
#pragma mark - MAMapViewDelegate（点击一个大头针时的事件）

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    _btnRight.enabled = YES;
    [_mapView removeOverlays:_pathPolylines];
    _pathPolylines = nil;
    for (int i = 0; i < _goodsArr.count; i++)
    {
        if (view.annotation == _annotationArr[i])
        {
            _Cview = [[MyItemsView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 120)];
            _Cview.alabel.text = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"GoodsSNID"]];
            [_Cview.imgView sd_setImageWithURL:[NSURL URLWithString:[_goodsArr[i] objectForKey:@"GoodsIntroducePic1FileID"]]];
            _Cview.numberLabel.text = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"UseTimes"]];
            _Cview.payLabel.text = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"GoodsUsePrice"]];
            _Cview.moneyLabel.text = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"Profit"]];

            NSString * x = [NSString stringWithFormat:@"%@",[_goodsArr[i] objectForKey:@"Status"]];
            if ([x isEqual: @"1"])
            {
                _Cview.stateLabel.text = @"待使用";
            }
            else if([x isEqual:@"2"])
            {
                _Cview.stateLabel.text = @"使用中";
            }
            else
            {
                _Cview.stateLabel.text = @"待审核";
            }
            [self.view addSubview: _Cview];
            MAPointAnnotation *a = [[MAPointAnnotation alloc]init];
            a = _annotationArr[i];
            self.startAnnotation.coordinate = self.mapView.userLocation.location.coordinate;
            self.destinationAnnotation.coordinate = a.coordinate;
            [self setWalkRouteParameter];
        }
        else
        {
            
        }
    }
}

/*设置步行路径*/

-(void)setWalkRouteParameter
{
    AMapWalkingRouteSearchRequest *request = [[AMapWalkingRouteSearchRequest alloc]init];
    request.origin = [AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude  ];
    request.destination = [AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude ];
    [_search AMapWalkingRouteSearch:request];
}

//  路径绘制
-(void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        return;
    }
    AMapPath *path = response.route.paths[0]; //选择一条路径
    AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
    NSLog(@"%@",step.polyline);   //此路段坐标点字符串
    
    if (response.count > 0)
    {
        //移除地图原本的遮盖
        [_mapView removeOverlays:_pathPolylines];
        _pathPolylines = nil;
        
        // 只显示第⼀条 规划的路径
        _pathPolylines = [self polylinesForPath:response.route.paths[0]];
        NSLog(@"%@",response.route.paths[0]);
        //添加新的遮盖，然后会触发代理方法进行绘制
        [_mapView addOverlays:_pathPolylines];
    }
}

//路线解析
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    return coordinates;
}

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        return accuracyCircleRenderer;
    }
    //画路线
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        //初始化一个路线类型的view
        MAPolylineRenderer *polygonView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        //设置线宽颜色等
        polygonView.lineWidth = 8.f;
        polygonView.strokeColor = [UIColor colorWithRed:0.015 green:0.658 blue:0.986 alpha:1.000];
        polygonView.fillColor = [UIColor colorWithRed:0.940 green:0.771 blue:0.143 alpha:0.800];
        polygonView.lineJoinType = kMALineJoinRound;//连接类型
        //返回view，就进行了添加
        return polygonView;
    }
    return nil;
}

//点击大头针以外地方的事件
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view
{
    [_Cview removeFromSuperview];
    [_mapView removeOverlays:_pathPolylines];
    _pathPolylines = nil;
    _btnRight.enabled = NO;
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
    
    //缩放按钮
    UIView *zoomPannelView = [self makeZoomPannelView];
    [self.view addSubview:zoomPannelView];
    [zoomPannelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.bottom.equalTo(-10);
        make.width.equalTo(53);
        make.height.equalTo(98);
    }];
}
//编辑物品
-(void)editItems
{
    NSLog(@"我要开始编辑");
    EditItemViewController *evc = [[EditItemViewController alloc]init];
    evc.GoodsSNID = _Cview.alabel.text;
    [self.navigationController pushViewController:evc animated:YES];
}

-(void)back
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
