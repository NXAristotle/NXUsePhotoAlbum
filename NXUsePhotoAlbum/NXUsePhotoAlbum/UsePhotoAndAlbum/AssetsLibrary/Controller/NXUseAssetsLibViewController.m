//
//  NXUseAssetsLibViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/7.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXUseAssetsLibViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NXUseAssetsLibCollectionViewController.h"
#import "NXUseAssetsLibModel.h"
#import "NXImagePickerViewController.h"

@interface NXUseAssetsLibViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showSelected;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray *groupArray;





@end

@implementation NXUseAssetsLibViewController

#pragma mark - 懒加载

- (NSMutableArray *)groupArray {
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (IBAction)selectFromAlbum:(UIButton *)sender {
 
    NXImagePickerViewController *imagePicker = [[NXImagePickerViewController alloc] init];
    
    [imagePicker setDidFinishSelectImageAssetsModels:^(NSMutableArray *model) {
        NSLog(@"选中了%zd个",model.count);
    }];
  
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}



    




@end
