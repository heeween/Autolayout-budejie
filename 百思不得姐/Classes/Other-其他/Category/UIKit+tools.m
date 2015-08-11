//
//  UIKit+tools.m
//  百思不得姐
//
//  Created by heew on 15/7/22.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "UIKit+tools.h"

@implementation UIBarButtonItem (navigation)
+ (instancetype)itemWithbg:(NSString *)bgimage bgHighlighted:(NSString *)bgimageHighlighted target:(id)obj action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setBackgroundImage:[[UIImage imageNamed:bgimage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setBackgroundImage:[[UIImage imageNamed:bgimageHighlighted] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:obj action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end

@implementation UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}
@end

@implementation UIImage (clipImage)
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)border borderColor:(UIColor *)color
{
    CGFloat bigSizeW = image.size.width + 2 * border;
    CGFloat bigSizeH = image.size.height + 2 * border;
    CGSize bigSize = CGSizeMake(bigSizeW, bigSizeH);
    UIGraphicsBeginImageContextWithOptions(bigSize, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, bigSizeW, bigSizeH)];
    [path fill];
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, image.size.width, image.size.height)];
    [innerPath addClip];
    CGPoint ctxPoint = CGPointMake(border, border);
    [image drawAtPoint:ctxPoint];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImage;
}
@end

@implementation UIImage (caputure)
+ (UIImage *)imageWithCaputureView:(UIView *)view
{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setViewCenterX:(CGFloat)viewCenterX
{
    CGPoint center = self.center;
    center.x = viewCenterX;
    self.center = center;
}

- (CGFloat)viewCenterX
{
    return self.center.x;
}

- (void)setViewCenterY:(CGFloat)viewCenterY
{
    CGPoint center = self.center;
    center.y = viewCenterY;
    self.center = center;
}

- (CGFloat)viewCenterY
{
    return self.center.y;
}

- (void)setViewWidth:(CGFloat)viewwidth
{
    CGRect frame = self.frame;
    frame.size.width = viewwidth;
    self.frame = frame;
}

- (void)setViewHeight:(CGFloat)viewheight
{
    CGRect frame = self.frame;
    frame.size.height = viewheight;
    self.frame = frame;
}

- (CGFloat)viewHeight
{
    return self.frame.size.height;
}

- (CGFloat)viewWidth
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
@end

@implementation UIView (xml)

- (NSString *)xmlWithViewComponent
{
    if ([self isKindOfClass:[UITableViewCell class]]) return @"";
    // 1.初始化
    NSMutableString *xml = [NSMutableString string];
    
    // 2.标签开头
    [xml appendFormat:@"<%@ frame=\"%@\"", self.class, NSStringFromCGRect(self.frame)];
    if (!CGPointEqualToPoint(self.bounds.origin, CGPointZero)) {
        [xml appendFormat:@" bounds=\"%@\"", NSStringFromCGRect(self.bounds)];
    }
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)self;
        if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, scroll.contentInset)) {
            [xml appendFormat:@" contentInset=\"%@\"", NSStringFromUIEdgeInsets(scroll.contentInset)];
        }
    }
    
    // 3.判断是否要结束
    if (self.subviews.count == 0) {
        [xml appendString:@" />"];
        return xml;
    } else {
        [xml appendString:@">"];
    }
    
    // 4.遍历所有的子控件
    for (UIView *child in self.subviews) {
        NSString *childXml = [child xmlWithViewComponent];
        [xml appendString:childXml];
    }
    
    // 5.标签结尾
    [xml appendFormat:@"</%@>", self.class];
    
    return xml;
    
}

@end
@implementation UIImageView (setHeaderImage)
- (void)setHeaderWithUrl:(NSString *)url {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = [UIImage imageWithClipImage:image borderWidth:0 borderColor:nil];
    }];
}



@end