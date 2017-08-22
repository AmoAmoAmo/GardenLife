//
//  SectionHeadView.h
//  GardenLife
//
//  Created by Jane on 16/5/7.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeadView : UIView


@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong)UIImageView *imgView;

-(void)changeImgViewStateWithFlag:(BOOL)isSelected;


@end
