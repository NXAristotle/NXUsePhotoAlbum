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
    //  查看授权状态
    ALAuthorizationStatus authorizationStatus =  [ALAssetsLibrary authorizationStatus];
    
    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    
    
    /*
     ALAuthorizationStatusNotDetermined NS_ENUM_DEPRECATED_IOS(6_0, 9_0) = 0, // User has not yet made a choice with regards to this application
     ALAuthorizationStatusRestricted NS_ENUM_DEPRECATED_IOS(6_0, 9_0),        // This application is not authorized to access photo data.
     // The user cannot change this application’s status, possibly due to active restrictions
     //  such as parental controls being in place.
     ALAuthorizationStatusDenied NS_ENUM_DEPRECATED_IOS(6_0, 9_0),            // User has explicitly denied this application access to photos data.
     ALAuthorizationStatusAuthorized NS_ENUM_DEPRECATED_IOS(6_0, 9_0)
     */
    
    switch (authorizationStatus) {
        case ALAuthorizationStatusNotDetermined:  //  用户还未做出选择
            
            break;
        case ALAuthorizationStatusRestricted:   //  受限制的
            
//            break;
        case ALAuthorizationStatusDenied:       //  用户拒绝
            tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
            // 展示提示语
            [[[UIAlertView alloc] initWithTitle:tipTextWhenNoPhotosAuthorization message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]  show];
            
            return;
            
            break;
        case ALAuthorizationStatusAuthorized:   //  用户授权
           
    
            break;
           
     
        default:
            break;
    }
    
    NSLog(@"authorizationStatus :%zd",authorizationStatus);
 
   
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    self.assetLibrary = assetLibrary;
   
    [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSInteger groupCount = [group numberOfAssets];
        NSLog(@"group number:%zd",groupCount);
        
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//            [group setAssetsFilter:[ALAssetsFilter allAssets]];

            if (group.numberOfAssets > 0) {
                // 把相册储存到数组中，方便后面展示相册时使用
                [self.groupArray addObject:group];
                
            }
        } else {
            if ([self.groupArray count] > 0) {
                // 把所有的相册储存完毕，可以展示相册列表
                [self enumerateAssets];
                
            } else {
                // 没有任何有资源的相册，输出提示
            }
        }
        
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Asset group not found!\n");
    }];
    
    NSLog(@"-- albumArray:%@",self.groupArray);
     
    

}


//  遍历相册
- (void)enumerateAssets {
    
    NSMutableArray * assets = [NSMutableArray new];
    for (ALAssetsGroup * group in self.groupArray) {
        
        
         // 遍历所有的相片
         [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
         if (result) { // 遍历未结束
             
         [assets addObject:result];
         } else { // result 为nil，遍历结束
             NSLog(@"assets‘s count : %zd",assets.count);
         
         }
         }];
       
        NSLog(@"assets's count :%zd",assets.count);
        
       
        /*
        NSInteger fromIndex = 0; // 重指定的index开始遍历
        NSInteger toIndex =5; // 指定最后一张遍历的index
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:toIndex] options:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (index > toIndex) { // 已经遍历到指定的最后一张照片
                *stop = YES; // 停止遍历
            } else {
                if (result) {
                    // 存储相片
                    [assets addObject:result];
                } else { // 遍历结束
                    // 展示图片
                    [self showPhotoWith:result];
                }
            }
        }];
        */
        
    }
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    NXUseAssetsLibCollectionViewController *VC = [[NXUseAssetsLibCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i<assets.count; i++) {
        NXUseAssetsLibModel *model = [[NXUseAssetsLibModel alloc] init];
        model.asset = assets[i];
        model.checked = NO;
        [modelArray addObject:model];
    }
    
    VC.assetArray = modelArray;
    
    [self.navigationController pushViewController:VC animated:YES];
    // 遍历指定的相片
    
    
}


- (void)showALAssetsGroupInfo:(ALAssetsGroup *)assetsGroup {
    
    // 是否可编辑,即相册是否可以通过代码添加相片
    //BOOL editable = assetsGroup.editable;
    
    // 添加一个ALAsset到当前相册,前提editable = YES，
    [assetsGroup addAsset:nil];
    
    /**
     + (ALAssetsFilter *)allPhotos; // 获取Photo
     + (ALAssetsFilter *)allVideos; // 获取Video
     + (ALAssetsFilter *)allAssets; // 获取Photo还有video
     */
    // 设置过滤器
    [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    
    // 当前过滤器下的ALAsset数量
   // NSInteger number = assetsGroup.numberOfAssets;
    
    /**
     NSString *const ALAssetsGroupPropertyName; // Group的名称
     NSString *const ALAssetsGroupPropertyType; // Group类型（ALAssetsGroupType）
     NSString *const ALAssetsGroupPropertyPersistentID;
     NSString *const ALAssetsGroupPropertyURL; // 唯一表示这个Group的URL，可以通过URL在资源库中获取对应的Group，用于唯一标识这个group
     */
    // 通过Property获取ALAssetsGroup对应的信息
    NSLog(@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]);
    NSLog(@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyType]);
    NSLog(@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID]);
    NSLog(@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyURL]);
    
    // 获取相册封面
    [assetsGroup posterImage];
    
}

- (void)showPhotoWith:(ALAsset *)asset {
    // 获取ALAsset对应的ALAssetRepresentation
    ALAssetRepresentation * representation = [asset defaultRepresentation];
    
    NSLog(@"%@", representation.url); // 图片URL
    NSLog(@"%@", NSStringFromCGSize(representation.dimensions)); // 图片尺寸
    NSLog(@"%lld", representation.size); // 数据字节
    NSLog(@"%@", representation.UTI); // Uniform Type Identifier : 统一类型标识符（表示图片或视频的类型）
    NSLog(@"%@", representation.filename); // 在相册中的文件名
    NSLog(@"%@", representation.metadata); // 元数据（一些设备相关的信息，比如使用的相机）
    NSLog(@"%lf", representation.scale); // 缩放比例
    NSLog(@"%ld", representation.orientation); // 方向
    /**
     fullScreenImage : 返回当前设备尺寸大小的图片，编辑后的图片
     fullResolutionImage ： 原图，没有编辑的图片
     */
    // 获取原图
  //  UIImage * image = [UIImage imageWithCGImage:[representation fullScreenImage] scale:1.0 orientation:UIImageOrientationDownMirrored];
//    self.imageView.image = image;
}




@end
