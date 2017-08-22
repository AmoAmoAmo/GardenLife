//
//  TipView.m
//  LoveFresh
//
//  Created by Jane on 16/4/26.
//  Copyright © 2016年 Jane. All rights reserved.
//
//  /** showTipView 背后满屏的黑色的view */

#import "TipView.h"
#import "ShowTipView.h"

@interface TipView()

@property (nonatomic,strong) ShowTipView *showTipView;
//@property (nonatomic,strong) UIView *myView;
/** 用来模糊背景的特效 - 毛玻璃 */
//@property (nonatomic, strong) UIVisualEffectView *effectview;


@end

@implementation TipView

+(instancetype)showTheTipView
{
    TipView *bgView = [[TipView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor clearColor];
//    bgView.alpha = 0.5;
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [bgView removeFromSuperview];
    });
    
    return bgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self addSubview:self.effectview];
        
        
        
        
        self.showTipView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        [self addSubview:self.showTipView];
        

//        self.myView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        [UIView animateWithDuration:0.3 animations:^{
            
            self.showTipView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.showTipView.transform = CGAffineTransformIdentity;
            }];
        }];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(ShowTipView *)showTipView
{
    if (!_showTipView) {
        
        _showTipView = [ShowTipView createShowTipView];
    }
    return _showTipView;
}

//-(UIVisualEffectView *)effectview
//{
//    if (!_effectview) {
//        //  创建需要的毛玻璃特效"类型"
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        
//        //  毛玻璃view "视图"
//        _effectview = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        _effectview.frame = [UIScreen mainScreen].bounds;
//        
//        _effectview.contentView.alpha = 0.1;
//        
//    }
//    return _effectview;
//}



@end
