//
//  NXUseAssetsLibCollectionViewCell.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/9.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NXUseAssetsLibModel,NXUseAssetsLibCollectionViewCell;

@protocol NXUseAssetsLibCollectionViewCellDelegate <NSObject>

@optional

- (void)NXUseAssetsLibCollectionViewCell:(NXUseAssetsLibCollectionViewCell *)cell didClickCheckboxButton:(BOOL )selected;

@end

@interface NXUseAssetsLibCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NXUseAssetsLibModel *model;  /**< 数据模型 */
@property (nonatomic, weak) id<NXUseAssetsLibCollectionViewCellDelegate> delegate;

@end
