//
//  NXUseAssetsLibCollectionViewController.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/10.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;
@interface NXUseAssetsLibCollectionViewController : UICollectionViewController

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;   /**< 数据模型 */

@end
