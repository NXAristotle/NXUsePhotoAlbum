//
//  NXUseAssetsLibCollectionViewCell.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/9.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXUseAssetsLibCollectionViewCell.h"
#import "NXUseAssetsLibModel.h"

@interface  NXUseAssetsLibCollectionViewCell ()


//@property (nonatomic, assign) BOOL isSelected;  /**< 是否被选中 */

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;  /**< 是否选中 */

@end

//@dynamic selected;

@implementation NXUseAssetsLibCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.isSelected = NO;
}

- (void)setModel:(NXUseAssetsLibModel *)model {
    _model = model;
    
    if (_model.checked) {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"Checkmark"] forState:UIControlStateNormal];
    }else
    {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"CheckmarkUnselected"] forState:UIControlStateNormal];
    }

    if (_model.thumbImage) {
        self.imageView.image = _model.thumbImage;
    }
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(NXUseAssetsLibCollectionViewCell:didClickCheckboxButton:)]) {
        [self.delegate NXUseAssetsLibCollectionViewCell:self didClickCheckboxButton:1];
    }
    
}

@end
