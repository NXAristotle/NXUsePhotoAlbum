//
//  NXSelectIconViewController.m
//  NXUsePhotoAlbum
//
//  Created by linyibin on 2017/3/6.
//  Copyright © 2017年 NXAristotle. All rights reserved.
//

#import "NXSelectIconViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#define kCellWidth 120

@interface NXSelectIconViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation NXSelectIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIActionSheet Delegate代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"选取图片的方式buttonIndex = [%zd]",buttonIndex);
    switch (buttonIndex) {
            
        case 0: // 照相机（拍照）
        {
            // 相机不可用时
            if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
                return;
            }
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
            break;
            
        case 1:// 本地相簿（手机相册）
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 设置可用的媒体类型、默认只包含kUTTypeImage，如果想选择视频，请添加kUTTypeMovie
            // 如果选择的是视屏，允许的视屏时长为20秒
            imagePicker.videoMaximumDuration = 20;
            // 允许的视屏质量（如果质量选取的质量过高，会自动降低质量）
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie, (NSString *)kUTTypeImage];
            
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
            
        }
            break;
            
        default:
            
            break;
    }
}

#pragma mark - UIImagePickerController Delegate代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"选择照片的info：%@",info);
    NSString *formatInfo = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
    NSLog(@"formatInfoformatInfo:%@",formatInfo);
    
   
        if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
            
            UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            //            UIImage *thumbImage = [self thumbnailWithImageWithoutScale:originalImage size:CGSizeMake(kCellWidth, kCellWidth)];
            UIImage *thumbImage = [self compresslWithImageWithoutScale:originalImage size:CGSizeMake(kCellWidth, kCellWidth)];
            
            self.iconImageView.image = thumbImage;
    
            
        }
        [picker dismissViewControllerAnimated:YES completion:^{
            //
            
        
        }];
    
    
}



#pragma mark - private method

- (IBAction)selectBtn:(UIButton *)sender {
    
    [self takePictureClick];
}

#pragma mark - 弹出actionsheet,选择获取头像的方式

-(void)takePictureClick
{
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"*所选取的照片将在邮件中显示"
                                  delegate:(id<UIActionSheetDelegate>)self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从手机相册选取",nil];
    [actionSheet showInView:self.view];
    
}

#pragma mark - 拉伸图片，填充整个image的比例压缩图片

- (UIImage *)compresslWithImageWithoutScale:(UIImage *)image size:(CGSize)asize {
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGRect rect = CGRectMake(0, 0, kCellWidth, kCellWidth);
        
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
