//
//  InfoView.h
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *fouceBtn;

@property (weak, nonatomic) IBOutlet UIView *bgView;
+(instancetype)createInfoView;

@end
