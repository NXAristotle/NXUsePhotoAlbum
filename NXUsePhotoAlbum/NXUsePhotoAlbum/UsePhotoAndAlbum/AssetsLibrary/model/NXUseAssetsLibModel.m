//
//  NXUseAssetsLibModel.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/9.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXUseAssetsLibModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation NXUseAssetsLibModel

- (void)originImage:(void (^)(UIImage *))getOriginImage {
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary assetForURL:self.originImageURL resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *rep = asset.defaultRepresentation;
        CGImageRef imageRef = rep.fullResolutionImage;
        UIImage *originImage = [UIImage imageWithCGImage:imageRef scale:rep.scale orientation:(UIImageOrientation)rep.orientation];
        if (originImage) {
            getOriginImage(originImage);
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"访问相册失败，失败原因：%@",error);
    }];
}


@end
