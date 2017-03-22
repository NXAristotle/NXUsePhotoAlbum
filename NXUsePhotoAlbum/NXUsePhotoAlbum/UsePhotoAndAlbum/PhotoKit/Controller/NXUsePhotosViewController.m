//
//  NXUsePhotosViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/16.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXUsePhotosViewController.h"
#import "NXPhotoKitTools.h"

@interface NXUsePhotosViewController ()

@end

@implementation NXUsePhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTestButton];
}

- (void)setupTestButton {
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setFrame:CGRectMake(0, 0, 200, 32)];
    [testButton setTitle:@"测试PhotoKit" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testButton setBackgroundColor:[UIColor colorFromHexRGB:@"3AA9E4"]];
    testButton.layer.cornerRadius = 5;
    testButton.layer.masksToBounds = YES;
    
    [testButton addTarget:self action:@selector(testPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    CGPoint center ;
    center = self.view.center;
    [testButton setCenter:center];
    [self.view addSubview:testButton];
}

- (void)testPhoto {
    NXPhotoKitTools *tools = [NXPhotoKitTools sharePhotoKitTools];
    NSArray *allAlbum = [NSArray arrayWithArray:[tools getAllAlbumList]];
   
    NSLog(@"---allAlbum :%@",allAlbum);
    
    
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
