//
//  NXPhotoKitTools.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/20.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXPhotoKitTools.h"


@implementation NXPhotoAblumModel


@end


static NXPhotoKitTools *photoKitTools = nil;

@implementation NXPhotoKitTools

+ (instancetype)sharePhotoKitTools {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photoKitTools = [[self alloc] init];
    });
    return photoKitTools;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photoKitTools = [super allocWithZone:zone];
    });
    return photoKitTools;
}

@end
