//
//  NXImagePickerViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/14.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXImagePickerViewController.h"
#import "NXUseAssetLibTableViewController.h"

@interface NXImagePickerViewController ()

@property (nonatomic, strong) NXUseAssetLibTableViewController *assetTableviewVC;

@end

@implementation NXImagePickerViewController

#pragma mark - life cycle

- (instancetype)init{
    
    if (self = [super initWithRootViewController:self.assetTableviewVC]) {
        UINavigationBar *navBar = [UINavigationBar appearance];
        //导航条背景色
        navBar.barTintColor = [UIColor colorFromHexRGB:@"3AA9E4"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    return  [self init];
}

- (NXUseAssetLibTableViewController *)assetTableviewVC {
    if (_assetTableviewVC == nil) {
        _assetTableviewVC = [[NXUseAssetLibTableViewController alloc] init];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"选择相册";
        titleLabel.font = [UIFont systemFontOfSize:22];
        [titleLabel sizeToFit];
        _assetTableviewVC.navigationItem.titleView = titleLabel;
        
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [backButton setTitle:@" 返回" forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        
        _assetTableviewVC.navigationItem.leftBarButtonItem = leftButtonItem;

        
    }
    return _assetTableviewVC;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
