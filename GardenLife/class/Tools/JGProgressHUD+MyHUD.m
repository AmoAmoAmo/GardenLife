//
//  JGProgressHUD+MyHUD.m
//  LoveFresh
//
//  Created by Jane on 16/4/13.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "JGProgressHUD+MyHUD.h"

@implementation JGProgressHUD (MyHUD)

+ (instancetype)showMessage:(NSString *)msg inViewController:(UIViewController *)viewController
{
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    hud.textLabel.text = msg;
    [hud showInRect:viewController.view.bounds inView:viewController.view animated:YES];
    
    return hud;
}

- (void)hides
{
    [self dismissAnimated:YES];
}



@end
