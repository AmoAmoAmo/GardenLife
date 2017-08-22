//
//  InfoView.m
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

-(void)awakeFromNib
{
    self.imgView.clipsToBounds = YES;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width*0.5;
    self.imgView.layer.borderWidth = .8f;
    self.imgView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.fouceBtn.clipsToBounds = YES;
    self.fouceBtn.layer.cornerRadius = 8;
    self.fouceBtn.layer.borderWidth = 1;
    self.fouceBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
}

+(instancetype)createInfoView
{
    InfoView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil][0];
    view.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64);//frame 是子控件在父控件中的位置
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (IBAction)clickFocusBtn:(UIButton *)sender {
    
    self.fouceBtn.selected = !self.fouceBtn.selected;
}




@end
