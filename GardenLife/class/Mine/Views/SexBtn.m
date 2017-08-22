//
//  SexBtn.m
//  LoveFresh
//
//  Created by Jane on 16/4/10.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "SexBtn.h"

@implementation SexBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeLeft;
        
        self.imageView.frame = CGRectMake(0, (frame.size.height-self.imageView.frame.size.height)/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
        self.titleLabel.frame = CGRectMake(30, 0, 60, frame.size.height);
    }
    return self;
}
//
//-(void)layoutSubviews
//{
//    
//}

@end
