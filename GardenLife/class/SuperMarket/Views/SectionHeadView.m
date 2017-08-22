//
//  SectionHeadView.m
//  GardenLife
//
//  Created by Jane on 16/5/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "SectionHeadView.h"

@implementation SectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.titleL.frame = CGRectMake(20, 0, SCREENWIDTH-40, self.frame.size.height);
        CGFloat width = 13;//imgView 的宽
        [self addSubview:self.titleL];
        self.imgView.frame = CGRectMake(SCREENWIDTH - 40 - width, (self.frame.size.height-width)/2+3, width, width-5);
        [self addSubview: self.imgView];
        
//        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
//        lineV.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:lineV];
    }
    return self;
}

-(void)changeImgViewStateWithFlag:(BOOL)isSelected
{
    if (isSelected) {
        [_imgView setImage:[UIImage imageNamed:@"cell_arrow_up_accessory"]];
    }else{
        
        [_imgView setImage:[UIImage imageNamed:@"cell_arrow_down_accessory"]];
    }
    
}


#pragma mark - setter and getter
-(UIImageView *)imgView
{
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"cell_arrow_down_accessory"]];
    }
    return _imgView;
}
-(UILabel *)titleL
{
    if (!_titleL) {
        
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont systemFontOfSize:14];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}


@end
