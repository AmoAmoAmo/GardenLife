//
//  MainViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MainViewController.h"
#import "HJNavigationController.h"

#import "HomeViewController.h"
#import "SuperMarketViewController.h"
#import "ShopCarViewController.h"
#import "MineViewController.h"

#import "HJTabBar.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildTabBar];
    
    
}


-(void)buildTabBar
{
    // 添加子控制器
    [self addChildVc:[[HomeViewController alloc] init] title:@"首页" image:@"home_2" selectedImage:@"home_2_sel"];
    [self addChildVc:[[SuperMarketViewController alloc] init] title:@"商城" image:@"store_2" selectedImage:@"store_2_sel"];
    [self addChildVc:[[ShopCarViewController alloc] init] title:@"购物车" image:@"car_2" selectedImage:@"car_2_sel"];
    [self addChildVc:[[MineViewController alloc] init] title:@"我" image:@"me" selectedImage:@"me_sel"];

    HJTabBar *hjTabBar = [[HJTabBar alloc] init];
    [self setValue:hjTabBar forKey:@"tabBar"];  // self.tabBar = hjTabBar
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    // 图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
//        childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
//    // 为子控制器包装导航控制器
    HJNavigationController *navigationVc = [[HJNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];

}



@end
