//
//  NXUseAssetsLibModel.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/9.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NXUseAssetsLibModel : NSObject

@property (nonatomic, copy)   NSURL *originImageURL;    /**< 原始图片地址 */
@property (nonatomic, strong) UIImage *thumbImage;      /**< 缩略图 */

@property (nonatomic, assign) BOOL checked;             /**< 是否被选中 */
@property (nonatomic, assign) BOOL isPhoto;             /**< 是否是图片 */

- (void)originImage:(void(^)(UIImage *image))getOriginImage;  //  获取原图

@end
