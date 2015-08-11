//
//  HYWTopicCell.m
//  百思不得姐
//
//  Created by heew on 14/7/27.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWTopicCell.h"
#import "HYWTopic.h"
#import "HYWTopicPictureView.h"
#import "HYWTopicVideoView.h"
#import "HYWTopicVoiceView.h"
#import "HYWComment.h"
#import "HYWUser.h"



@interface HYWTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profile_image; // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; // 昵称
@property (weak, nonatomic) IBOutlet UILabel *create_timeLabel; // 发布时间
@property (weak, nonatomic) IBOutlet HYWContentButton *dingButton; // 顶
@property (weak, nonatomic) IBOutlet HYWContentButton *caiButton; // 踩
@property (weak, nonatomic) IBOutlet HYWContentButton *repostButton; // 分享
@property (weak, nonatomic) IBOutlet HYWContentButton *commentButton; // 评论
@property (weak, nonatomic) IBOutlet UIImageView *profile_AddV_View; // 会员标
@property (weak, nonatomic) IBOutlet UILabel *contentLabel; // 文字部分
@property (weak, nonatomic) IBOutlet UIView *multiMediaView; // 多媒体内容框
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *multiMediaViewHeight;
@property (nonatomic, weak) HYWTopicPictureView *pictureView; /**显示图片的控件 */
@property (nonatomic, weak) HYWTopicVideoView *videoView; /**显示视频的控件 */
@property (nonatomic, weak) HYWTopicVoiceView *voiceView; /**显示视频的控件 */
@property (weak, nonatomic) IBOutlet UILabel *topCommentTitleLabel; /**热评论标题 */
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel; /**热门评论内容 */
@end




@implementation HYWTopicCell
- (HYWTopicPictureView *)pictureView {
    if (_pictureView == nil) {
        HYWTopicPictureView *pictureView = [HYWTopicPictureView pictureView];
        [self.multiMediaView addSubview:pictureView];
        [pictureView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.multiMediaView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _pictureView = pictureView;
    }
    return _pictureView;
} // 图片控件懒加载

- (HYWTopicVideoView *)videoView
{
    if (_videoView == nil) {
        HYWTopicVideoView *videoView = [HYWTopicVideoView videoView];
        [self.multiMediaView addSubview:videoView];
        [videoView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.multiMediaView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _videoView = videoView;
    }
    return _videoView;
} // 视频空间懒加载

- (HYWTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        HYWTopicVoiceView *voiceView = [HYWTopicVoiceView voiceView];
        [self.multiMediaView addSubview:voiceView];
        [voiceView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.multiMediaView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _voiceView = voiceView;
    }
    return _voiceView;
} // 声音懒加载

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    self.contentLabel.autoresizingMask = UIViewAutoresizingNone;
    self.contentLabel.preferredMaxLayoutWidth = HYWScreenW - 4 * HYWTopicCellMargin;
    self.topCommentTitleLabel.autoresizingMask = UIViewAutoresizingNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    HYWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topic"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
} // 构造方法

- (void)setTopic:(HYWTopic *)topic {
    _topic = topic;
    [self.profile_image setHeaderWithUrl:topic.profile_image]; // 头像
    self.nameLabel.text = topic.name; // 标题
    self.create_timeLabel.text = topic.create_time; // 发表时间
    [self.dingButton setTitleCount:topic.ding placeholder:@"顶"]; // 顶
    [self.caiButton setTitleCount:topic.cai placeholder:@"踩"]; // 踩
    [self.repostButton setTitleCount:topic.repost placeholder:@"分享"]; // 分享
    [self.commentButton setTitleCount:topic.comment placeholder:@"评论"]; // 评论
    self.contentLabel.text = topic.text; // 正文
    self.profile_AddV_View.hidden = !topic.isSina_v; // 判断会员标
    self.multiMediaViewHeight.constant = topic.pictureSize.height; // 更新约束
    if (topic.type == HYWTopicPictureType) { // 图片模型
        self.pictureView.topic = self.topic; // 传递模型
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
//        self.multiMediaViewBottom.constant = 10;
    } else if (topic.type == HYWTopicVideoType) {
        self.videoView.topic = self.topic;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
    } else if (topic.type == HYWTopicVoiceType) {
        self.voiceView.topic = self.topic;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
    } else if (topic.type == HYWTopicTextType) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    if (topic.top_cmt) {
        self.topCommentLabel.hidden = NO;
        self.topCommentTitleLabel.hidden = NO;
        self.topCommentTitleLabel.text = @"最新评论";
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@:%@",topic.top_cmt.user.username,topic.top_cmt.content];
    }else {
        self.topCommentTitleLabel.hidden = YES;
        self.topCommentLabel.hidden = YES;
    }
} // 传递模型
@end




@implementation HYWContentButton
- (void)setTitleCount:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [self setTitle:placeholder forState:UIControlStateNormal];
} // 设置按钮文字
@end


@implementation HYWTopicCellBgView
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage resizableImage:@"mainCellBackground"];
    [image drawInRect:rect];
}
@end
