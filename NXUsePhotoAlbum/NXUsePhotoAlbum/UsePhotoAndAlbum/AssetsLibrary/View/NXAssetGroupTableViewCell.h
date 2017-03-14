//
//  NXAssetGroupTableViewCell.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/14.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;

@interface NXAssetGroupTableViewCell : UITableViewCell

@property (nonatomic,strong) ALAssetsGroup *group;

+ (instancetype)AssetGroupTableViewCell:(UITableView *)tableView;

@end
