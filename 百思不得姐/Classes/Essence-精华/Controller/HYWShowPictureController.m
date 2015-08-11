//
//  XMGShowPictureViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 14/7/29.
//  Copyright (c) 2014年 heew. All rights reserved.
//

#import "HYWShowPictureController.h"
#import "HYWTopic.h"
#import "HYWProgressView.h"

@interface HYWShowPictureController ()
@property (weak, nonatomic) IBOutlet HYWProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageviewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageviewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewCenterYConstraint;
@end

@implementation HYWShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 图片约束
    CGFloat pictureH = HYWScreenW * self.topic.height / self.topic.width;
    self.imageviewWidthConstraint.constant = HYWScreenW;
    self.imageviewHeightConstraint.constant = pictureH;
    self.imageViewCenterYConstraint.priority = pictureH > HYWScreenH ? UILayoutPriorityDefaultLow : UILayoutPriorityRequired;
    
    
    // 下载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
    
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    error ? [SVProgressHUD showErrorWithStatus:@"保存失败!"] :[SVProgressHUD showSuccessWithStatus:@"保存成功!"];
}
@end
