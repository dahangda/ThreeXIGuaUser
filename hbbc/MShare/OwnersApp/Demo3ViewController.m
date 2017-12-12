//
//  Demo3ViewController.m
//  微博照片选择
//
//  Created by 洪欣 on 17/2/17.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "Demo3ViewController.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface Demo3ViewController ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong)NSArray *networkPhotos;

@end

@implementation Demo3ViewController

-(NSArray *)networkPhotos
{
    if (!_networkPhotos)
    {
        _networkPhotos = [NSArray array];
    }
    return _networkPhotos;
}


- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
//                _manager.openCamera = NO;
        _manager.outerCamera = YES;
        _manager.showDeleteNetworkPhotoAlert = NO;
        _manager.saveSystemAblum = YES;
        _manager.photoMaxNum = 2; // 这里需要注意 !!!  第一次传入的最大照片数 是可选最大数 减去 网络照片数量   即   photoMaxNum = maxNum - networkPhotoUrls.count  当点击删除网络照片时, photoMaxNum 内部会自动加1
        _manager.videoMaxNum = 0;
        _manager.maxNum = 6;
        
        _manager.networkPhotoUrls = [NSMutableArray arrayWithObjects:@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/003d86db-b140-4162-aafa-d38056742181.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg", nil];
    }
    return _manager;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getItemInfo];
//    [self initUI];
}

-(void)getItemInfo
{
    NSDictionary *parameters = @{
                                 @"ECID":OwnerECID,
                                 @"PhoneNumber":@"15093337480",
                                 @"GoodsSNID":_GoodsSNID
                                 };
    [[NetworkSingleton shareManager] httpRequest:parameters url:OWNERITEMDETAIL success:^(id responseBody){
        DHResponseBodyLog(responseBody);
        self.networkPhotos = responseBody[@"PicList"];
        
        [self initUI];
    } failed:^(NSError *error)
     {
         DHErrorLog(error);
     }];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = scrollView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 64, width - kPhotoViewMargin * 2, 0);
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    photoView.manager = self.manager;
}


- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchHDImageType completion:^(NSArray<UIImage *> *images) {
        NSSLog(@"%@",images);
    }];
}


- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}


@end
