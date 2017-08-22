//
//  MessageViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets= NO;
    self.title = @"消息";
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREENWIDTH-200)*0.5, (SCREENHEIGHT-100)*0.5-50, 200, 100)];
    label.text = @"暂时没有消息~";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    
    self.view.backgroundColor = AUTOCOLOR;
    [self.view addSubview:label];
}

@end
