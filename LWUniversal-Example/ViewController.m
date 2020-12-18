//
//  ViewController.m
//  LWUniversal-Example
//
//  Created by Liang Wang (QXW7463) on 2020/12/17.
//

#import "ViewController.h"
#import <LWUniversalKit/LWUniversalKit.h>
@interface ViewController ()<SDPhotoBrowserDelegate>

@property(nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestObject *objc = [[TestObject alloc] init];
    [objc testPrint];
    NSString *version = kAppVersion;
    DLog(@"xxxx%@===%d==%@",version, [UniDevice iPhone12Mini], [UniDevice UUIDString]);
    [self testRequest];
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [UIColor redColor];
    [self.button addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.button.sd_layout
    .leftEqualToView(self.view).offset(10)
    .centerYEqualToView(self.view)
    .widthIs(100)
    .heightEqualToWidth();
}

- (void)showImage {
//    NSArray *images = @[@"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
//                        @"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
//                        @"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
//                        @"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
//                        @"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"];
    NSArray *images = @[@"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"];
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self.button;
    browser.imageCount = images.count;
    browser.delegate = self;
    [browser show];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.label.text = @"添加中...";
//    [hud showAnimated:YES];
//
//    [hud hideAnimated:YES afterDelay:2];
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        // Do something...
//        sleep(2);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        });
//    });
    
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.label.text = @"Loading";
//    [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
//        hud.progress = progress;
//    } completionCallback:^{
//        [hud hideAnimated:YES];
//    }];

//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        // Do something...
//        sleep(3);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    });
    
    
    
}

- (void)testRequest {
    PMBaseParams *p = [PMBaseParams initWithModule:@"BaseParam" method:@"list" AndParams:@{}];
    __weak typeof(self) weakSelf = self;
    [UniNetworkManager RequestDataWithParaters:p successBlock:^(id responseObject, NSDictionary *userInfo) {
        if ([[responseObject objectForKey:@"procRespCode"] integerValue] == 200) {
            NSLog(@"xxx==%@",responseObject);
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark - SDPhotoBrowserDelegate
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    return [NSURL URLWithString:@"http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
//    UIImageView *imageView = self.view.subviews[index];
    return [UIImage new];
}

- (void)photoBrowserDidDismiss:(SDPhotoBrowser *)browser {
}

@end
