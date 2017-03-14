//
//  NXUseAssetsLibModel.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/9.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface NXUseAssetsLibModel : NSObject

@property (nonatomic, strong) NSString *originURL;  /**< 原始图片地址 */
@property (nonatomic, strong) NSString *thumbURL;   /**< 缩略图地址 */

@property (nonatomic, assign) BOOL checked;        /**< 是否被选中 */
@property (nonatomic, strong) ALAsset *asset;      /**< 资源 */

@end
