//
//  SettingViewController.m
//  LoveFresh
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBarTintColor:nil];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setUI
{
    
    self.view.backgroundColor = [UIColor redColor];
    
}
@end
