//
//  MyAddressViewController.h
//  LoveFresh
//
//  Created by Jane on 16/4/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyAddressViewControllerDelegate <NSObject>

-(void)changTitleLabelWithText:(NSString *)text andDataDic:(NSDictionary *)dic;

@end

@interface MyAddressViewController : UIViewController

@property (nonatomic, assign) id<MyAddressViewControllerDelegate> delegate;//weak

@property (nonatomic, copy) NSString *flagStr;

@end
