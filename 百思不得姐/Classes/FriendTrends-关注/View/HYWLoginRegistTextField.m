//
//  HYWLoginRegistTextField.m
//  百思不得姐
//
//  Created by heew on 15/7/26.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWLoginRegistTextField.h"
#import <objc/runtime.h>

@implementation HYWLoginRegistTextField

- (void)awakeFromNib {
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)resignFirstResponder {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    self.attributedPlaceholder = attrString;
    return [super resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : self.textColor}];
    self.attributedPlaceholder = attrString;
    return [super becomeFirstResponder];
}

@end
