//
//  NXImagePickerViewController.h
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/14.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXImagePickerViewController : UINavigationController

@property (nonatomic,copy) void(^didFinishSelectImageAssetsModels)(NSMutableArray *models);


@end
