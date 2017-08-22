//
//  OrderCountView.h
//  LoveFresh
//
//  Created by Jane on 16/4/23.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCountView : UIView
@property (weak, nonatomic) IBOutlet UILabel *sendLabel;
@property (weak, nonatomic) IBOutlet UILabel *seviseLabel;
@property (weak, nonatomic) IBOutlet UILabel *tickLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

+(instancetype)createOrderCountViewWithData:(NSDictionary*)dic;

@end
