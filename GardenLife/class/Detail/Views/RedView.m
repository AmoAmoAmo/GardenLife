//
//  RedView.m
//  LoveFresh
//
//  Created by Jane on 16/4/26.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "RedView.h"

@interface RedView ()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation RedView


+(instancetype)shareRedView
{
    static RedView *redView;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        redView = [[RedView alloc] init];
    });
    
    
    return redView;
}


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//        
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 20, 20)];
    if (self) {
        
        [self addSubview:self.bgImgView];
        [self addSubview:self.numLabel];
        
        if (self.buyNum == 0) {
            self.numLabel.text = @"";
            self.hidden = YES;
        }
        
        // 创建 小红点的时候，添加KVO 监听购物车总数的变化
        [self addObserver:self forKeyPath:@"buyNum" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}



#pragma mark - KVO 监听购物车总数的变化，实时更新
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.buyNum == 0) {
        self.numLabel.text = @"";
        self.hidden = YES;
    }else{
        self.hidden = NO;
        self.numLabel.text = [NSString stringWithFormat:@"%ld",self.buyNum];
    }
}
-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"buyNum"];
}

-(void)addRedToTabBar
{
    
}



-(void)addProductToRedDotView
{
    // 延时加载动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.buyNum++;
        [self reddotAnimation];
    });
    
}

-(void)reduceProductToRedDotView
{
    if (self.buyNum > 0) {
        self.buyNum--;
    }
    [self reddotAnimation];
}

-(void)reddotAnimation
{
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.buyNum];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.transform = CGAffineTransformIdentity;
        }];
    }];
}






-(UILabel *)numLabel
{
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _numLabel.font = [UIFont systemFontOfSize:10];
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.text = @"";
    }
    return _numLabel;
}
-(UIImageView *)bgImgView
{
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [_bgImgView setImage:[UIImage imageNamed:@"reddot"]];
    }
    return _bgImgView;
}

@end
