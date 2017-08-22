//
//  AuthorViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "AuthorViewController.h"
#import "InfoView.h"

@interface AuthorViewController ()

@property (nonatomic, strong) UIScrollView *bgScroll;

@property (nonatomic, strong) UIImageView *bgImgView;

@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    if (!self.dataDic) {
        [self setUIIfNoValue];
    }else{
        [self setValue];
    }
    [self addKVO];
}

-(void)setUI
{
    [self.view addSubview:self.bgImgView];
    // bgImgView 的黑色蒙版
    UIView *bgView = [[UIView alloc] initWithFrame:self.bgImgView.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.25;
    [self.view addSubview:bgView];
    
    
    self.title = @"关注";
    [self.view addSubview:self.bgScroll];

}

-(void)setValue
{
    [_bgImgView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"headImg"]] placeholderImage:PLACEIMAGE];
    
    InfoView *view = [InfoView createInfoView];
    [self.bgScroll addSubview:view];
    [view.imgView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"headImg"]] placeholderImage:PLACEIMAGE];
    view.nameLabel.text = self.dataDic[@"userName"];
    view.subLabel.text = self.dataDic[@"identity"];
    view.textLabel.text = self.dataDic[@"content"];
    view.bgView.clipsToBounds = YES;
    view.bgView.layer.cornerRadius = 10;
}

-(void)setUIIfNoValue
{
    [_bgImgView setImage:[UIImage imageNamed:@"themeImage"]];
    
    InfoView *view = [InfoView createInfoView];
    [self.bgScroll addSubview:view];
    [view.imgView setImage:[UIImage imageNamed:@"themeImage"]];
    view.nameLabel.text = @"花田小憩";
    view.subLabel.text = @"官方认证";
    view.textLabel.text = @"定义自己的美好生活";
    view.bgView.clipsToBounds = YES;
    view.bgView.layer.cornerRadius = 10;
}

-(void)addKVO
{
    [self.bgScroll addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat y = self.bgScroll.contentOffset.y;
    CGFloat yy = y + 40;
    
    if (yy < 0) {
        
        self.bgImgView.frame = CGRectMake(yy*0.5, 64, SCREENWIDTH + (-yy)*1, SCREENWIDTH + (-yy));
    }
    if (y > 0) {
        
        self.bgImgView.frame = CGRectMake(0, 64 - (y)/2, SCREENWIDTH, SCREENWIDTH);
    }
}
-(void)dealloc
{
    [_bgScroll removeObserver:self forKeyPath:@"contentOffset"];
}



-(UIImageView *)bgImgView
{
    if (!_bgImgView) {
        
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENWIDTH)];
        
        
    }
    return _bgImgView;
}

-(UIScrollView *)bgScroll
{
    if (_bgScroll == nil) {
        
        _bgScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _bgScroll.contentSize = CGSizeMake(0, SCREENHEIGHT-64);
        _bgScroll.alwaysBounceVertical = YES;
    }
    return _bgScroll;
}


@end
