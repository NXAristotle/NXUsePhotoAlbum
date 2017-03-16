//
//  NXUseAssetLibTableViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/14.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXUseAssetLibTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NXAssetGroupTableViewCell.h"
#import "NXUseAssetsLibCollectionViewController.h"

#define kCellHeight  64

@interface NXUseAssetLibTableViewController ()

@end

@implementation NXUseAssetLibTableViewController

#pragma mark - 懒加载
- (ALAssetsLibrary *)assetsLibrary {
    if (_assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        
    }
    return _assetsLibrary;
}


- (NSMutableArray<ALAssetsGroup *> *)groupArray {
    if (_groupArray == nil) {
        
        _groupArray = [NSMutableArray array];
        
        //  是否需要在此查看授权
        [self checkoutAuthorizationStatus];
        
        /*
         开启 Photo Stream 容易导致 exception
         本质上，这跟上面的 AssetsLibrary 遵循写入优先原则是同一个问题。如果用户开启了共享照片流（Photo Stream），共享照片流会以 mstreamd 的方式“偷偷”执行，当有人把相片写入 Camera Roll 时，它就会自动保存到 Photo Stream Album 中，如果用户刚好在读取，那就跟上面说的一样产生 exception 了。由于共享照片流是用户决定是否要开启的，所以开发者无法改变，但是可以通过下面的接口在需要保护的时刻关闭监听共享照片流产生的频繁通知信息。
         */
        [ALAssetsLibrary disableSharedPhotoStreamsSupport];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //  AssetsLibrary 实例需要强引用,避免被ARC释放
            [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                NSLog(@"group name : %@",name);
                if ([group numberOfAssets] < 1) return;
                

                
                if (group != nil) {
                    [_groupArray addObject:group];
                    [self.tableView reloadData];
                }
              
                
            } failureBlock:^(NSError *error) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"访问相册失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }];
            
            
//            [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupPhotoStream usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//                
//            } failureBlock:^(NSError *error) {
//                
//            }];
        });
        
    }
    return _groupArray;
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupBackBtn];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NXAssetGroupTableViewCell *cell = [NXAssetGroupTableViewCell AssetGroupTableViewCell:tableView];
    
    cell.group = self.groupArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALAssetsGroup *group = self.groupArray[indexPath.row];
    if (group.numberOfAssets != 0) {
        NXUseAssetsLibCollectionViewController *VC = [[NXUseAssetsLibCollectionViewController alloc] init];
        VC.assetsGroup = group;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}



#pragma mark - private method


- (void)setupTableView {
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)setupBackBtn {
    //返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [backButton setTitle:@" 返回相册" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [backButton setImage:[UIImage imageNamed:@"arrowLeft"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.backBarButtonItem = leftButtonItem;
}


- (void)checkoutAuthorizationStatus {
    //  查看授权状态
    ALAuthorizationStatus authorizationStatus =  [ALAssetsLibrary authorizationStatus];
    
    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    
    
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
}



@end
