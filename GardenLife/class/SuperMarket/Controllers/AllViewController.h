//
//  AllViewController.h
//  GardenLife
//
//  Created by Jane on 16/5/4.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllViewController : UIViewController

@property (nonatomic,assign) NSInteger flag;
@property (nonatomic,copy) NSString *idStr;

@property (nonatomic,strong) NSMutableArray *dataArrFromTheme;

@end
