//
//  QuesHeadView.m
//  LoveFresh
//
//  Created by Jane on 16/4/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "QuesHeadView.h"
#import "QuestionsModel.h"

@interface QuesHeadView()

//@property (nonatomic,strong)UIImageView *imgView;


@end

@implementation QuesHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.titleL.frame = CGRectMake(20, 10, SCREENWIDTH-40, 30);
        CGFloat width = 15;//imgView 的宽
        [self addSubview:self.titleL];
        self.imgView.frame = CGRectMake(SCREENWIDTH - 20 - width, (50-width)/2, width, width-5);
        [self addSubview: self.imgView];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineV];
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
    }
    return _titleL;
}

@end
