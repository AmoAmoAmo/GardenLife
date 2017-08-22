//
//  QuesHeadView.h
//  LoveFresh
//
//  Created by Jane on 16/4/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuesHeadView : UIView

@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong)UIImageView *imgView;
//@property(nonatomic,assign) BOOL isSelected;
//@property (nonatomic,assign) NSInteger index;

//-(void)createViewWithModel:(QuestionsModel*)model;

-(void)changeImgViewStateWithFlag:(BOOL)isSelected;

@end
