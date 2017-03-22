//
//  NXPhotoKitTools.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/20.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


//相册的model
@interface NXPhotoAblumModel : NSObject

@property (nonatomic, copy)   NSString *title;  /**< 相册名 */
@property (nonatomic, assign) NSInteger count;  /**< 该相册的资源数量 */
@property (nonatomic, strong) PHAsset *posterImageAsset; /**< 相册的海报 */
@property (nonatomic, strong) PHAssetCollection *assetCollection; /**< 相册集，通过该属性获取该相册集下所有资源
 */

@end

@interface NXPhotoKitTools : NSObject

+ (instancetype)sharePhotoKitTools;


/**
 * @brief 获取智能相册（系统）列表
 */
- (NSArray<NXPhotoAblumModel *> *)getAllSmartAlbumList;

/**
 * @brief 获取用户所有相册列表
 */
- (NSArray<NXPhotoAblumModel *> *)getAllUserAlbumList;

/**
 * @brief 获取所有相册列表(包括智能相册和用户相册)
 */
- (NSArray<NXPhotoAblumModel *> *)getAllAlbumList;


/**
 * @brief 获取相册内所有图片资源
 * @param ascending 是否按创建时间正序排列 YES,创建时间正（升）序排列 | NO,创建时间倒（降）序排列
 */
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;


/**
 * @brief 获取指定相册内的所有图片
 */
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;


/**
 * @brief 获取每个Asset对应的图片
 */
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;


/**
 删除系统相册中的照片，单个或者多个
 
 @param assets 要删除的照片数组
 @param completionHandler 成功的回调
 */
- (void)deleteSystemPhothWithPhotos:(NSArray<PHAsset *>*)assets successHandler:(dispatch_block_t)completionHandler;

#pragma mark - 判断软件是否有相册访问权限
+ (BOOL)photoAblumAuthorization;

#pragma mark - 判断软件是否有相机访问权限
+ (BOOL)cameraAuthorization;


@end
