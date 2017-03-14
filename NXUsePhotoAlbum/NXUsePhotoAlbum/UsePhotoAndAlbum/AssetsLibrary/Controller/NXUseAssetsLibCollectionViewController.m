//
//  NXUseAssetsLibCollectionViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/10.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXUseAssetsLibCollectionViewController.h"
#import "NXUseAssetsLibCollectionViewCell.h"
#import "NXUseAssetsLibModel.h"

#define screenWidth    [UIScreen mainScreen].bounds.size.width
#define screenHeight   [UIScreen mainScreen].bounds.size.height

@interface NXUseAssetsLibCollectionViewController ()<NXUseAssetsLibCollectionViewCellDelegate>


@end

@implementation NXUseAssetsLibCollectionViewController

static NSString * const reuseIdentifier = @"NXUseAssetsLibCollectionViewCell";

#pragma mark - 懒加载

- (NSMutableArray *)assetArray {
    
    if (_assetArray == nil) {
        _assetArray = [NSMutableArray array];
        
    }
    return _assetArray;
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
  
    // Do any additional setup after loading the view.
    [self setupCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupCollectionView {
    
    self.collectionView.backgroundColor = [UIColor whiteColor];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   
  
    // Register cell classes
//    [self.collectionView registerClass:[NXUseAssetsLibCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NXUseAssetsLibCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NXUseAssetsLibModel *model = self.assetArray[indexPath.row];

    cell.model = model;
    cell.delegate = self;
    
  
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = screenWidth / 5;
    return CGSizeMake(width, width);
}

#pragma mark - NXUseAssetsLibCollectionViewCellDelegate

- (void)NXUseAssetsLibCollectionViewCell:(NXUseAssetsLibCollectionViewCell *)cell didClickCheckboxButton:(BOOL)selected {
    NSLog(@"当前是 ：%zd",selected);
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    NSLog(@"indexPath : %@",indexPath);

    NXUseAssetsLibModel *model = self.assetArray[indexPath.row];
    
    model.checked = !model.checked;

    NSArray *indexpathArray = [NSArray arrayWithObject:indexPath];
    [self.collectionView reloadItemsAtIndexPaths:indexpathArray];
    
    
}


@end
