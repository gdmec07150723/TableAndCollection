//
//  HeaderReusableView.m
//  TableViewAndCollection
//
//  Created by INTCO 王伟 on 2017/1/10.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "HeaderReusableView.h"

@implementation HeaderReusableView

- (instancetype) initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor purpleColor];
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 20)];
        _title.backgroundColor = [UIColor magentaColor];
        [self addSubview:_title];
    }
    return self;
}

@end
