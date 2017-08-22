//
//  PJView.h
//  LoveFresh
//
//  Created by Jane on 16/4/22.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJView : UIView
@property (weak, nonatomic) IBOutlet UIButton *starBtn1;
@property (weak, nonatomic) IBOutlet UIButton *starBtn2;
@property (weak, nonatomic) IBOutlet UIButton *starBtn3;
@property (weak, nonatomic) IBOutlet UIButton *starBtn4;
@property (weak, nonatomic) IBOutlet UIButton *starBtn5;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

+(instancetype)createFootViewWithData:(NSDictionary*)dic;

@end
