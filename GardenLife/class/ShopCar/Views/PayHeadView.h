//
//  PayHeadView.h
//  LoveFresh
//
//  Created by Jane on 16/5/1.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;

+(instancetype)createPayHeadViewWithDataDic:(NSDictionary *)dic;

@end
