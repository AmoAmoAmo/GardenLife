//
//  OrderHeadView.h
//  LoveFresh
//
//  Created by Jane on 16/4/22.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendLabel;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *psLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSDictionary *dataDic;

+(instancetype)createHeadViewWithData:(NSDictionary *)dataDic;

@end
