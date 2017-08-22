//
//  JGProgressHUD+MyHUD.h
//  LoveFresh
//
//  Created by Jane on 16/4/13.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "JGProgressHUD.h"

/**
 *  HUD的简易封装，用起来更方便
 */
@interface JGProgressHUD (MyHUD)



/**
 *  显示HUD，并显示文本提示
 *
 *  @param msg            要显示的文本
 *  @param viewController 在哪个控制器显示
 *
 *  @return 创建好，并已经显示的HUD
 */
+ (instancetype)showMessage:(NSString *)msg inViewController:(UIViewController *)viewController;

/**
 *  隐藏HUD
 */
- (void)hides;

@end
