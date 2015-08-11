//
//  UIKit+tools.h
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <UIKit/UIKit.h>

// 创建一个自定义的导航条按钮
@interface UIBarButtonItem (navigation)
+ (instancetype)itemWithbg:(NSString *)bgimage bgHighlighted:(NSString *)bgimageHighlighted target:(id)obj action:(SEL)action;
@end

/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name;
@end

/**
 *  返回一张圆切的图片
 */
@interface UIImage (clipImage)
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)border borderColor:(UIColor *)color;
@end

/**
 *
 *  @param  view需要截图的控件
 *
 *  返回一个view的截图
 */
@interface UIImage (caputure)
+ (UIImage *)imageWithCaputureView:(UIView *)view;
@end


@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat viewCenterX;
@property (nonatomic, assign) CGFloat viewCenterY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;
@end

@interface UIView (xml)

- (NSString *)xmlWithViewComponent;

@end

@interface UIImageView (setHeaderImage)
- (void)setHeaderWithUrl:(NSString *)url;

@end

