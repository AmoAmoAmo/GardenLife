//
//  MineViewController.m
//  Demo－1
//
//  Created by Jane on 16/3/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MineViewController.h"
#import "MyAddressViewController.h"
#import "SettingViewController.h"
#import "MyOrderViewController.h"
#import "QuestionViewController.h"
#import "LikeViewController.h"
#import "MessageViewController.h"
#import "YiJianViewController.h"
#import "UMSocial.h"
#import "MineCell.h"

#define BGHEIGHT 180
/** top的3个view */
#define ViewHeight 70


@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>

@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIImageView *userIcon;

@property (nonatomic,strong) UIView *addrView;
@property (nonatomic,strong) UIView *orderView;
@property (nonatomic,strong) UIView *questionView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = AUTOCOLOR;
    self.navigationController.hidesBottomBarWhenPushed= YES;
    self.tabBarController.tabBar.hidden = NO;
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void)setUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.table];
    //    //cell注册方式
    //    [self.table registerNib:[UINib nibWithNibName:@"FirstCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    // head...
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BGHEIGHT + ViewHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, BGHEIGHT)];
    ImgView.image = [UIImage imageNamed:@"blur1"];
    [headView addSubview:ImgView];
    [headView addSubview:self.userIcon];
    
    [headView addSubview:self.addrView];
    [headView addSubview:self.orderView];
    [headView addSubview:self.questionView];
    
    
    self.table.tableHeaderView = headView;
}



#pragma mark - 点击顶部的3个view
-(void)clickTopView:(UITapGestureRecognizer*)tap
{
    if (tap.view == self.addrView) {
        
        MyAddressViewController *vc = [[MyAddressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (tap.view == self.orderView){
    
        MyOrderViewController *vc = [[MyOrderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else{
    
        QuestionViewController *vc = [[QuestionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
//返回每个cell的高度，这里高度是固定的，可以直接写死, 如果高度是不固定的需要先调用estimatedHeightForRowAtIndexPath:方法给个预计高度
//等网络请求完毕后根据cell内容算出高度 再调用heightForRowAtIndexPath：设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.section * 2;
    NSDictionary *dic = self.dataArr[indexPath.row + index];
    
    return [MineCell cellWithTableView:tableView andDataDic:dic];
}






#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            LikeViewController *vc = [[LikeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            SettingViewController *vc = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            MessageViewController *vc = [[MessageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            // 邀请好友   分享
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:nil
                                              shareText:@"今天天气不错"
                                             shareImage:[UIImage imageNamed:@"1.jpg"]
                                        shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToTencent,UMShareToWechatTimeline,UMShareToQzone,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,UMShareToFacebook,UMShareToTwitter]
                                               delegate:self];
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            
        }else{
            
            YiJianViewController *vc = [[YiJianViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
    
}


#pragma mark - scroll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tabBarController.tabBar.hidden = NO;
}




#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49) style:UITableViewStyleGrouped];//style:UITableViewStylePlain(默认 设置分组有悬浮)
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;

}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MinePlist" ofType:@"plist"];
        _dataArr = [NSMutableArray arrayWithContentsOfFile:path];
        
    }
    return _dataArr;
}

-(UIImageView *)userIcon
{
    if (!_userIcon) {
        
        _userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3-1"]];//
        _userIcon.clipsToBounds = YES;
        _userIcon.frame = CGRectMake(SCREENWIDTH/2 - 50, BGHEIGHT/2-50+10, 100, 100);
        _userIcon.layer.cornerRadius = 50;
        _userIcon.layer.borderWidth = .7f;
        _userIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _userIcon;
}

-(UIView *)addrView
{
    if (!_addrView) {
        _addrView = [[UIView alloc] initWithFrame:CGRectMake(0, BGHEIGHT, SCREENWIDTH/3.0, ViewHeight)];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH/3.0-35)*0.5, 10, 35, 35)];
        [imgView setImage:[UIImage imageNamed:@"addr2"]];
        [_addrView addSubview:imgView];
        
        UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame)+5, SCREENWIDTH/3.0 - 20, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"地址管理";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        [_addrView addSubview:label];
        
        UIView *lineView= [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3.0-1, 10, 1, ViewHeight-20)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.6;
        [_addrView addSubview:lineView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTopView:)];
        _addrView.userInteractionEnabled = YES;
        [_addrView addGestureRecognizer:tap];
        
    }
    return _addrView;
}
-(UIView *)orderView
{
    if (!_orderView) {
        _orderView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3.0, BGHEIGHT, SCREENWIDTH/3.0, ViewHeight)];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH/3.0-35)*0.5, 10, 35, 35)];
        [imgView setImage:[UIImage imageNamed:@"order"]];
        [_orderView addSubview:imgView];
        
        UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame)+5, SCREENWIDTH/3.0 - 20, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我的订单";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        [_orderView addSubview:label];
        
        UIView *lineView= [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH/3.0-1, 10, 1, ViewHeight-20)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.alpha = 0.6;
        [_orderView addSubview:lineView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTopView:)];
        _orderView.userInteractionEnabled = YES;
        [_orderView addGestureRecognizer:tap];
    }
    return _orderView;
}
-(UIView *)questionView
{
    if (!_questionView) {
        _questionView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH-SCREENWIDTH/3.0, BGHEIGHT, SCREENWIDTH/3.0, ViewHeight)];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH/3.0-35)*0.5, 10, 35, 35)];
        [imgView setImage:[UIImage imageNamed:@"ques"]];
        [_questionView addSubview:imgView];
        
        UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame)+5, SCREENWIDTH/3.0 - 20, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"常见问题";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        [_questionView addSubview:label];

        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTopView:)];
        _questionView.userInteractionEnabled = YES;
        [_questionView addGestureRecognizer:tap];
    }
    return _questionView;
}
@end
