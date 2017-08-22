//
//  LikeView.m
//  GardenLife
//
//  Created by Jane on 16/5/9.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "LikeView.h"
#import "HomeModel.h"

@interface LikeView();

//@property (nonatomic,strong) UIButton *likeBtn;
//@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation LikeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 120, 20)];
    if (self) {
        
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 120, 20);
        
        [self addSubview:self.likeBtn];
        [self addSubview:self.numLabel];
    }
    return self;
}

+(instancetype)createLikeViewWithIsLike:(BOOL)isLike andNum:(NSInteger)num
{
    LikeView *view = [[LikeView alloc] init];
    view.likeBtn.selected = isLike;
    view.numLabel.text = [NSString stringWithFormat:@"%ld",num];
    
    return view;
}


-(void)isLike
{
    [self animationForLikeBtnClick];
    NSString *numStr =  self.numLabel.text;
    self.numLabel.text = [NSString stringWithFormat:@"%d",[numStr intValue]+1];
    // 更新为选中状态
//    NSLog(@"%@",self.numLabel.text);//self.dataDic[@"newFavo"]//self.model.collectedNum
    self.likeBtn.selected = YES;
    
    // **** 插入数据库 ****
    FMDBmanager *manager = [FMDBmanager shareInstance];
    NSString *sqlStr = nil;
    
    if (self.dataDic) {
        sqlStr = [NSString stringWithFormat:@"insert into Like (idStr ,icon ,name , rzStr ,lookNum ,imgUrl ,title ,category , commentNum , desStr , likeNum , createDate ) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",self.dataDic[@"id"],self.dataDic[@"author"][@"headImg"],self.dataDic[@"author"][@"userName"],self.dataDic[@"author"][@"identity"],[NSString stringWithFormat:@"%@",self.dataDic[@"newRead"]],self.dataDic[@"smallIcon"],self.dataDic[@"title"],self.dataDic[@"category"][@"name"],self.dataDic[@"fnCommentNum"],self.dataDic[@"desc"],[NSString stringWithFormat:@"%@",self.numLabel.text],self.dataDic[@"createDate"]];
    }else{
        sqlStr = [NSString stringWithFormat:@"insert into Like (idStr ,icon ,name , rzStr ,lookNum ,imgUrl ,title ,category , commentNum , desStr , likeNum , createDate ) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",self.model.idStr, self.model.iconImgStr, self.model.nameStr, self.model.rzStr, self.model.liulangStr, self.model.imgUrlStr, self.model.titleStr, self.model.categoryStr, self.model.huifuStr, self.model.desStr, self.numLabel.text, self.model.createDateStr];
    }
//    NSLog(@"sqlStr ***** %@",sqlStr);
    if(![manager.dataBase executeUpdate:sqlStr])
    {
        NSLog(@"插入失败....");
    }
    
    // 发送从数据库更新的通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LikeTableDidChanged" object:self];

}

/** 
 @property (nonatomic,copy) NSString *idStr;
 
 @property (nonatomic, copy) NSString *imgUrlStr;
 @property (nonatomic, copy) NSString *iconImgStr;
 @property (nonatomic, copy) NSString *nameStr;
 @property (nonatomic, copy) NSString *rzStr;
 @property (nonatomic, copy) NSString *categoryStr;
 @property (nonatomic, copy) NSString *titleStr;
 @property (nonatomic, copy) NSString *desStr;
 
 @property (nonatomic, copy) NSString *liulangStr;
 @property (nonatomic, copy) NSString *collectedNum;
 @property (nonatomic, copy) NSString *huifuStr;
 */

-(void)canselLike
{
    [self animationForLikeBtnClick];
    NSString *numStr =  self.numLabel.text;
//    NSLog(@"%@",numStr);
    if ([numStr intValue] > 0) {
        self.numLabel.text = [NSString stringWithFormat:@"%d",[numStr intValue]-1];
    }
    // 更新为未选中状态
    self.likeBtn.selected = NO;
    
    
    // **** 从数据库删除 ****
    FMDBmanager *manager = [FMDBmanager shareInstance];
    NSString *sqlStr = nil;
    
    if (self.dataDic) {
        sqlStr = [NSString stringWithFormat:@"delete from Like where idStr = '%@'", self.dataDic[@"id"]];
    }else{
        sqlStr = [NSString stringWithFormat:@"delete from Like where idStr = '%@'", self.model.idStr];
    }
    
//    NSLog(@"sqlStr ******* %@",sqlStr);
    if(![manager.dataBase executeUpdate:sqlStr])
    {
        NSLog(@"删除失败....");
    }
    
//    // 发送从数据库更新的通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LikeTableDidChanged" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LikeTableNeedToReload" object:self];
}

-(void)animationForLikeBtnClick
{
    [UIView animateWithDuration:0.3 animations:^{
//        NSLog(@"1111111111");
        self.likeBtn.transform = CGAffineTransformMakeScale(1.4, 1.4);
        
    } completion:^(BOOL finished) {
//        NSLog(@"2222222222");
        [UIView animateWithDuration:0.3 animations:^{
            self.likeBtn.transform = CGAffineTransformMakeScale(0.7, 0.7);
//            NSLog(@"33333333333");
        } completion:^(BOOL finished) {
//            NSLog(@"4444444444444");
            [UIView animateWithDuration:0.2 animations:^{
//                NSLog(@"5555555555");
                self.likeBtn.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}




#pragma mark - 懒加载
-(UIButton *)likeBtn
{
    if (!_likeBtn) {
        
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeBtn.frame = CGRectMake(0, 1, 18, 18);
        
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"ic_nav_black_heart_off"] forState:UIControlStateNormal];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"ic_nav_black_heart_on"] forState:UIControlStateSelected];
    }
    return _likeBtn;
}

-(UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 100, 20)];
        _numLabel.font = [UIFont systemFontOfSize:12];
        _numLabel.textColor = [UIColor darkGrayColor];
    }
    return _numLabel;
}

@end
