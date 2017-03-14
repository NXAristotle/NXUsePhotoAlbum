//
//  NXUseAssetLibTableViewController.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/14.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsLibrary,ALAssetsGroup;

@interface NXUseAssetLibTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<ALAssetsGroup *> *groupArray;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end
