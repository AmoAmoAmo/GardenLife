//
//  ShowTipView.m
//  
//
//  Created by Jane on 16/4/26.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ShowTipView.h"

/** 宽 */
#define SHOWWIDTH 200
/** 高度 */
#define VHeight 150


@interface ShowTipView()

@property (nonatomic,strong) ShowTipView *view;

@end

@implementation ShowTipView

//-(void)awakeFromNib
//{
//    
//}

+(instancetype)createShowTipView
{
//    ShowTipView *view = [[ShowTipView alloc] initWithFrame:CGRectMake(ZYMargin, (SCREENHEIGHT - VHeight)*0.5 - 40, SCREENWIDTH - 2*ZYMargin, VHeight)];
    ShowTipView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
//    view.backgroundColor = [UIColor yellowColor];
    view.frame = CGRectMake((SCREENWIDTH-SHOWWIDTH)*0.5, (SCREENHEIGHT - VHeight)*0.5 - 80, SHOWWIDTH, VHeight);
    
    view.bgView.layer.cornerRadius = 8;
    view.bgView.clipsToBounds = YES;
//    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    return view;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        
//    }
//    return self;
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
