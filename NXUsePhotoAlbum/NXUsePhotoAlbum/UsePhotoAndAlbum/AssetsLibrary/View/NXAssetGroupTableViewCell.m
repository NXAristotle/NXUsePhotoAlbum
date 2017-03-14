//
//  NXAssetGroupTableViewCell.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/14.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXAssetGroupTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kMargin  8

static NSString * const reuseIdentifier = @"NXAssetGroupTableViewCell";


@implementation NXAssetGroupTableViewCell


+ (instancetype)AssetGroupTableViewCell:(UITableView *)tableView {
    
    NXAssetGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[NXAssetGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
    
}

- (void)setGroup:(ALAssetsGroup *)group {
    
    // 将已只相册名切换为中文
    NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
    if ([groupName isEqualToString:@"Camera Roll"]) {
        groupName = @"相机";
    } else if ([groupName isEqualToString:@"My Photo Stream"]) {
        groupName = @"我的照片";
    }
    
    //  设置
    [group setAssetsFilter:[ALAssetsFilter allAssets]];
    
    NSInteger groupCount = [group numberOfAssets];  //  该相册组内的照片数量
   
    self.textLabel.text = [NSString stringWithFormat:@"%@ , %zd",groupName,groupCount];
    
    UIImage *groupIcon = [UIImage imageWithCGImage:group.posterImage];
    [self.imageView setImage:groupIcon];
    
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat cellHeight = self.frame.size.height - 2 * kMargin;
    self.imageView.frame = CGRectMake(kMargin, kMargin, cellHeight, cellHeight);
}


@end
