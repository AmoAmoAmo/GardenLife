//
//  HJNavigationController.m
//  Demo－1
//
//  Created by Jane on 16/3/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "HJNavigationController.h"
#import "UMSocial.h"

@interface HJNavigationController ()<UMSocialUIDelegate>

@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *shareBtn;

@end

@implementation HJNavigationController


// 只初始化一次
+ (void)initialize
{
    // 设置项目中item(按钮)的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // Normal
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置项目中title的主题样式
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [self.navigationBar setTitleTextAttributes:dic];
}

#pragma mark 重写方法
/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {// 如果不是根视图控制器  // 此时push进来的viewController是第二个子控制器
        // 自动隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        // 定义leftBarButtonItem
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
        
        // 定义rightBarButtonItem
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }
    // 调用父类pushViewController，self.viewControllers数组添加对象viewController
    [super pushViewController:viewController animated:animated];
    /** 重新设置返回手势的代理给nav */
    self.interactivePopGestureRecognizer.delegate = (id)self;
}


#pragma methord
-(void)clickBackBtn
{
    [self popViewControllerAnimated:YES];
}
-(void)clickShareBtn
{
    // 邀请好友   分享
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:@"今天天气不错"
                                     shareImage:[UIImage imageNamed:@"1.jpg"]
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToTencent,UMShareToWechatTimeline,UMShareToQzone,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter]
                                       delegate:self];
}

#pragma mark - setter and getter
-(UIButton *)backBtn
{
    if (!_backBtn) {
        
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"ic_nav_left"] forState:UIControlStateNormal];
        _backBtn.titleLabel.hidden =YES;
        _backBtn.frame = CGRectMake(0, 0, 25, 25);
        [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        _shareBtn.titleLabel.hidden = YES;
        _shareBtn.frame = CGRectMake(0, 0, 25, 25);
        [_shareBtn addTarget:self action:@selector(clickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

@end
