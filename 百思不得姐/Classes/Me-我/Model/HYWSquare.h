//
//  HYWSquare.h
//  百思不得姐
//
//  Created by heew on 15/8/4.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYWSquare : NSObject
@property (nonatomic, strong) NSString *android; /**支持所安装app的版本编号 */
@property (nonatomic, strong) NSString *icon; /**按钮的图片地址 */
@property (nonatomic, strong) NSString *ID; /**按钮的id编号 */
@property (nonatomic, strong) NSString *ipad; /**支持iPhone所安装的app的版本编号 */
@property (nonatomic, strong) NSString *iphone; /**支持的iPhone所安装的app的版本编号 */
@property (nonatomic, strong) NSString *name; /**按钮名称 */
@property (nonatomic, strong) NSString *url; /**”webview所加载的url */
@end
