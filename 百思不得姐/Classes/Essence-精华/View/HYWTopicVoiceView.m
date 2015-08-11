//
//  HYWTopicVoiceView.m
//  百思不得姐
//
//  Created by heew on 15/7/31.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWTopicVoiceView.h"
#import "HYWTopic.h"
#import "HYWProgressView.h"
#import "HYWShowPictureController.h"


@interface HYWTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView; // 图片
@property (weak, nonatomic) IBOutlet HYWProgressView *progressView; // 进度条控件
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@end


@implementation HYWTopicVoiceView

+ (instancetype) voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}



- (IBAction)showPicture
{
    HYWShowPictureController *showPicture = [[HYWShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [HYWKeyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
- (void)setTopic:(HYWTopic *)topic
{
    _topic = topic;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // 如果是大图片, 才需要进行绘图处理
        if (!topic.isBigPicture) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureSize, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureSize.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd",minute,second];
}
@end
