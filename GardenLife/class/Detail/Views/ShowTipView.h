//
//  ShowTipView.h
//  
//
//  Created by Jane on 16/4/26.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTipView : UIView
@property (weak, nonatomic) IBOutlet UIView *bgView;

//+(instancetype)showTipView;
+(instancetype)createShowTipView;// superview addsubview,  然后自动remove



@end
