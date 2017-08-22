//
//  AnimationViewController.m
//  LoveFresh
//
//  Created by Jane on 16/4/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

//@property (nonatomic, strong)CALayer *myLayers;
@property (nonatomic, strong)NSMutableArray *myLayersArr;

@property (nonatomic, strong)UIImageView *imgView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)addProductsAnimationWithImageView:(UIImageView *)imageView
{
    // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
    // 把UITableViewCell中的subview(btn)的frame转换到 self.view 中
    CGRect myFrame = [imageView convertRect:imageView.bounds toView:self.view];
    
//    CGFloat Ix = myFrame.origin.x;
//    CGFloat Iy = myFrame.origin.y;
//    [self.view addSubview:self.imgView];
//    self.imgView.frame = CGRectMake(Ix , Iy , 25, 25);
    
    
    CALayer *layer1 = [[CALayer alloc] init];
    layer1.frame = myFrame;
//    layer1.frame = self.imgView.frame;
//    layer1.contents = self.imgView.layer.contents;
    layer1.contents = imageView.layer.contents;
    [self.view.layer addSublayer:layer1];
    [self.myLayersArr addObject:layer1];
    
    //*********
    // ** 图片初始的位置
    CGPoint beginPoint = layer1.position;
    // ** 购物车左上角圆圆的红点位置
    CGPoint endPoint = CGPointMake(SCREENWIDTH-SCREENWIDTH/4 - SCREENWIDTH/8 - 6, SCREENHEIGHT-40);
    
    // 2.创建一个CGMutablePathRef 的可变路径，并返回其句柄
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, beginPoint.x, beginPoint.y);
    CGPathAddCurveToPoint(path, nil, beginPoint.x, beginPoint.y-30, endPoint.x, beginPoint.y-30, endPoint.x, endPoint.y);
    
    //1.创建核心动画
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animation];
    positionAnimation.keyPath = @"position";
    positionAnimation.path = path;
    
    //*********
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.9];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = YES;
    
    //*********
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1)];
    
    //*********
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
//    groupAnimation.animations = @[positionAnimation, transformAnimation, opacityAnimation];
    groupAnimation.animations = [NSArray arrayWithObjects:positionAnimation, transformAnimation, opacityAnimation, nil];
    groupAnimation.duration = 0.8;
    groupAnimation.delegate = self;
    
    //**********
    [layer1 addAnimation:groupAnimation forKey:@"cartParabola"];
//    [self.view.layer addAnimation:groupAnimation forKey:nil];
}

#pragma mark - 重写方法
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.myLayersArr.count > 0) {
    
//        CALayer *tempLayer = self.myLayersArr[0];
//        tempLayer.hidden = YES;
////        self.imgView.hidden = YES;
//        [tempLayer  removeFromSuperlayer];
//        tempLayer = nil;
        for (CALayer *layerT in self.myLayersArr) {
            layerT.hidden = YES;
            [layerT removeFromSuperlayer];
//            layerT = nil;
        }
        [self.myLayersArr removeAllObjects];
        self.myLayersArr = nil;
        [self.view.layer removeAnimationForKey:@"cartParabola"];
    }
}


#pragma mark - setter and getter
-(NSMutableArray *)myLayersArr
{
    if (!_myLayersArr) {
        _myLayersArr = [NSMutableArray array];
    }
    return _myLayersArr;
}

-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_test_entry_icon"]];
    }
    return _imgView;
}

@end
