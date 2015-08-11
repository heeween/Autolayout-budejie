//
//  HYWCommnetHeaderFooter.m
//  百思不得姐
//
//  Created by heew on 15/8/3.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "HYWCommnetHeaderFooter.h"

@interface HYWCommnetHeaderFooter ()
@property (nonatomic, weak) UILabel *label; /**标题 */
@end

@implementation HYWCommnetHeaderFooter



+ (instancetype)HeaderFooterViewWithTableView:(UITableView *)tableview {
    HYWCommnetHeaderFooter *headerFooterView = [tableview dequeueReusableHeaderFooterViewWithIdentifier:commentHeaderFooter];
    if (headerFooterView == nil) {
        headerFooterView = [[self alloc] initWithReuseIdentifier:commentHeaderFooter];
    }
    return headerFooterView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = HYWColr(67, 67, 67);
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        }];
        self.label = label;
        self.contentView.backgroundColor = HYWColr(223, 223, 223);
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}
@end
