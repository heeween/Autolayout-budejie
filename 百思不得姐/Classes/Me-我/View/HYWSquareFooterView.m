//
//  HYWSquareFooterView.m
//  百思不得姐
//
//  Created by heew on 15/8/4.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWSquareFooterView.h"
#import "HYWSquare.h"
#import "HYWWebController.h"

static NSInteger const kMaxCol = 4;

@implementation HYWSquareFooterView


- (void)setSquares:(NSArray *)squares {
    _squares = squares;
    [self setup];
    self.viewHeight = HYWScreenW / kMaxCol * (self.squares.count + kMaxCol - 1) / kMaxCol;
}

- (void)setup {
    for (int i = 0; i < self.squares.count; i++) {
        HYWSquareButton *button = [HYWSquareButton buttonWithType:UIButtonTypeCustom];
        HYWSquare *square = self.squares[i];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
        [button setTitle:square.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button {
    NSInteger index = [self.subviews indexOfObject:button];
    HYWSquare *square = self.squares[index];
    HYWWebController *webVc = [[HYWWebController alloc] init];
    webVc.square = square;
    UITabBarController *tabVc = (UITabBarController *)HYWKeyWindow.rootViewController;
    UINavigationController *currentNav = (UINavigationController *)tabVc.selectedViewController;
    [currentNav pushViewController:webVc animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat ButtonW = HYWScreenW / kMaxCol;
    CGFloat ButtonH = ButtonW;
    for (int i = 0; i < self.squares.count; i++) {
        HYWSquareButton *button = self.subviews[i];
        NSInteger col = i % kMaxCol;
        NSInteger row = i / kMaxCol;
        CGFloat ButtonX = col * ButtonW;
        CGFloat ButtonY = row * ButtonH;
        button.frame = CGRectMake(ButtonX, ButtonY, ButtonW, ButtonH);
    }
}

@end



@implementation HYWSquareButton

//- (void)setTitle:(NSString *)title forState:(UIControlState)state
//{
//    [super setTitle:title forState:state];
//    [self.titleLabel sizeToFit];
//}
//
//- (void)setImage:(UIImage *)image forState:(UIControlState)state
//{
//    [super setImage:image forState:state];
//    [self sizeToFit];
//}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片位置
    self.imageView.y = self.viewHeight * 0.15;
    self.imageView.viewWidth = self.viewWidth * 0.5;
    self.imageView.viewHeight = self.imageView.viewWidth;
    self.imageView.viewCenterX = self.viewWidth * 0.5;

    // 设置标题位置
    self.titleLabel.x = 0;    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + HYWTopicCellMargin;
    self.titleLabel.viewWidth = self.viewWidth;
    self.titleLabel.viewHeight = self.viewHeight - self.titleLabel.y;
    
}
@end

