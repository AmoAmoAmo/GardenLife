//
//  DetailViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "DetailViewController.h"
#import "BuyView.h"
#import "AuthorViewController.h"
#import "NSString+CoutDate.h"
#import "LikeView.h"
#import "HomeModel.h"
#import "BuyView.h"
#import "RedView.h"
#import "FMDBmanager.h"
#import "ShopCarViewController.h"
#import "TipView.h"

/** web... */
#define GoodsURL @"http://m.htxq.net/shop/PGoodsAction/goodsDetail.do?goodsId=%@"
#define TopicURL @"http://m.htxq.net//servlet/SysArticleServlet?action=preview&artId=%@"

@interface DetailViewController ()<UIWebViewDelegate,BuyViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,copy) NSString *urlStr;

@property (nonatomic,strong) LikeView *likeView;

//@property (nonatomic,strong) HomeModel *myModel;

/** 属于goods的左下角的imageView */
@property (nonatomic,strong) UIImageView *imgView;

/** +、-按钮和label的view */
@property (nonatomic,strong) BuyView *buyView;

@property (nonatomic,strong) RedView *redView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view
    

    [self addNotification];
    
    self.title  = self.titleStr;
    if ([self.flagStr isEqualToString:@"topic"] || [self.flagStr isEqualToString:@"top"] || [self.flagStr isEqualToString:@"db"]) {
        // topic
        
        _urlStr = [NSString stringWithFormat:TopicURL,self.idStr];
        [self buildWebView];
        [self buildHeader];
        [self buildTopViewAndBottomView];
    }else{
        // goods
        
        _urlStr = [NSString stringWithFormat:GoodsURL,self.idStr];
        [self buildWebView];
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        [self buildBottomViewAndTopView];
    }
    
//    NSLog(@"_urlStr === %@",_urlStr);
    
    
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"redViewNeedToReset" object:self];
}


-(void)buildWebView
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;
    
}

-(void)buildTopViewAndBottomView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 26, 26)];
//    [iconImgView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"author"][@"headImg"]] placeholderImage:PLACEIMAGE];
    [iconImgView sd_setImageWithURL:[NSURL URLWithString:_myModel.iconImgStr] placeholderImage:PLACEIMAGE];
    iconImgView.clipsToBounds = YES;
    iconImgView.layer.cornerRadius = 13;
    iconImgView.layer.borderWidth = .6f;
    iconImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [topView addSubview:iconImgView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImgView.frame)+5, 13, 100, 15)];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = [UIColor darkGrayColor];
//    nameLabel.text = self.dataDic[@"author"][@"userName"];
    nameLabel.text = _myModel.nameStr;
    [nameLabel sizeToFit];
    [topView addSubview:nameLabel];
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+8, 13, 100, 15)];
    subLabel.font = [UIFont systemFontOfSize:12];
    subLabel.textColor = [UIColor darkGrayColor];
//    subLabel.text = self.dataDic[@"author"][@"identity"];
    subLabel.text = _myModel.rzStr;
    [subLabel sizeToFit];
    [topView addSubview:subLabel];
    
    UIImageView *lookImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(subLabel.frame)+20, 14, 15, 13)];
    [lookImg setImage:[UIImage imageNamed:@"look"]];
    [topView addSubview:lookImg];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lookImg.frame)+2, 13, 100, 15)];
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.textColor = [UIColor lightGrayColor];
//    numLabel.text = [NSString stringWithFormat:@"浏览%@",self.dataDic[@"newRead"]];
    numLabel.text = [NSString stringWithFormat:@"浏览%@",_myModel.liulangStr];
    [numLabel sizeToFit];
    [topView addSubview:numLabel];
    
    [self.view addSubview:topView];
    
    topView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTopView)];
    [topView addGestureRecognizer:tap];
    
//    *********** bottomView ***********
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-38, SCREENWIDTH, 38)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineView];
    
    
    UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, (38-15)*0.5, 15, 15)];
    [icon1 setImage:[UIImage imageNamed:@"time"]];
    [bottomView addSubview:icon1];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon1.frame)+8, (38-15)*0.5, 100, 15)];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor darkGrayColor];
    //    *********
//    NSString *createDateStr = self.dataDic[@"createDate"];
    NSString *createDateStr = _myModel.createDateStr;
    NSString *resultStr = [createDateStr countDateString];
//    NSLog(@"resultStr == %@",resultStr);
    timeLabel.text = resultStr;
    [timeLabel sizeToFit];
    [bottomView addSubview:timeLabel];
    
    

    _likeView = [LikeView createLikeViewWithIsLike:0 andNum:[_myModel.collectedNum integerValue]];
    _likeView.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+30, (38-20)*0.5, 120, 20);
    
    if ([self.flagStr isEqualToString:@"db"] || [self.flagStr isEqualToString:@"top"]) {
        _likeView.model = self.myModel;
    }else{
        _likeView.dataDic = self.dataDic;
    }
    [_likeView.likeBtn addTarget:self action:@selector(clickLikeBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_likeView];
    [self loadDataFromDBForLikeView];
    
    
    UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_likeView.frame), (38-15)*0.5, 16, 13)];
    [icon2 setImage:[UIImage imageNamed:@"comment"]];
    [bottomView addSubview:icon2];
    
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon2.frame)+8, (38-15)*0.5, 100, 15)];
    commentLabel.font = [UIFont systemFontOfSize:12];
    commentLabel.textColor = [UIColor darkGrayColor];
//    commentLabel.text = [NSString stringWithFormat:@"%@",self.dataDic[@"fnCommentNum"]];
    commentLabel.text = [NSString stringWithFormat:@"%@",_myModel.huifuStr];
    [commentLabel sizeToFit];
    [bottomView addSubview:commentLabel];
    
    
    [self.view addSubview:bottomView];
}
/** webView的header */
-(void)buildHeader
{
    CGFloat imgHeight = 160;
    CGFloat titleHeight = 40;
    CGFloat subHeight = 30;
    
    UIView *headView= [[UIView alloc] initWithFrame:CGRectMake(0, -250, SCREENHEIGHT, 250)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.webView.scrollView addSubview:headView];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(250+40, 0, 0, 0);
    //    self.webView.scrollView.backgroundColor = [UIColor clearColor];
    

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 160)];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"smallIcon"]] placeholderImage:PLACEIMAGE];
    [imgView sd_setImageWithURL:[NSURL URLWithString:_myModel.imgUrlStr] placeholderImage:PLACEIMAGE];
    [headView addSubview:imgView];
    
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+10, SCREENWIDTH, titleHeight)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = self.dataDic[@"title"];
    titleLabel.text = _myModel.titleStr;
    [headView addSubview:titleLabel];
    
    UILabel *subLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, titleHeight+imgHeight+5, SCREENWIDTH, subHeight)];
    subLabel.font = [UIFont systemFontOfSize:14];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.textColor = [UIColor darkGrayColor];
//    subLabel.text = [NSString stringWithFormat:@"#%@#",self.dataDic[@"category"][@"name"]];
    subLabel.text = [NSString stringWithFormat:@"#%@#",_myModel.categoryStr];
    [headView addSubview:subLabel];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH*0.5-30, titleHeight+subHeight+imgHeight+10, 60, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:lineV];
    
}


// goods
-(void)buildBottomViewAndTopView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-38, SCREENWIDTH, 38)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineView];
    
    [bottomView addSubview:self.imgView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, (38-20)*0.5, 60, 20)];
    priceLabel.textColor= [UIColor darkGrayColor];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.text = self.priceStr;
    [bottomView addSubview:priceLabel];
    
    // buyView
    [bottomView addSubview:self.buyView];
    
    
    
    [self.view addSubview:bottomView];
    
    
    //*************
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UILabel *carLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, 0, 100, 40)];
    carLabel.font = [UIFont systemFontOfSize:13];
    carLabel.backgroundColor = [UIColor darkGrayColor];
    carLabel.textColor = [UIColor whiteColor];
    carLabel.textAlignment = NSTextAlignmentCenter;
    carLabel.text = @"去购物车看看";
    [topView addSubview:carLabel];
    
    carLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCarLabel)];
    [carLabel addGestureRecognizer:tap];
    
    [topView addSubview:self.redView];
    
    [self.view addSubview:topView];
}



#pragma mark - 设置likeView选中状态 从数据库读取
-(void)loadDataFromDBForLikeView
{
    FMDBmanager *manager = [FMDBmanager shareInstance];
    NSString *sqlStr = nil;
    
    if (self.dataDic) {
        sqlStr = [NSString stringWithFormat:@"select * from Like where idStr = '%@'",self.dataDic[@"id"]];
    }else{
        sqlStr = [NSString stringWithFormat:@"select * from Like where idStr = '%@'",self.myModel.idStr];
    }
    
    //    NSLog(@"sqlStr ==== %@",sqlStr);
    FMResultSet *rs = [manager.dataBase executeQuery:sqlStr];
    while ([rs next]) {
        _likeView.likeBtn.selected = YES;
        _likeView.numLabel.text = [NSString stringWithFormat:@"%ld",[[rs stringForColumn:@"likeNum"] integerValue]];
    }
}



#pragma mark - BuyViewDelegate 点击“+”按钮
-(void)buyViewDidCilckAddBtn
{
    // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
    // 把UITableViewCell中的subview(btn)的frame转换到 self.view 中
    CGRect myFrame = [self.imgView convertRect:self.imgView.bounds toView:self.view];
    CALayer *layer1 = [[CALayer alloc] init];
    layer1.frame = myFrame;

    UIImageView *tempImgView = [[UIImageView alloc] initWithFrame:myFrame];
    tempImgView.image = self.imgView.image;
    [self.view addSubview:tempImgView];
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 11.0 ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0;
    
    //这个是让旋转动画慢于缩放动画执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tempImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    });
    
    [UIView animateWithDuration:1.2 animations:^{
        tempImgView.frame = CGRectMake(SCREENWIDTH-100-10-2, 3+64, 0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - 点击返回购物车
-(void)clickCarLabel
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    // 延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NeedToShowCarVC" object:self];
    });

}


#pragma mark - 点击TopView
-(void)clickTopView
{
    AuthorViewController *vc = [[AuthorViewController alloc] init];
    
    if ([self.flagStr isEqualToString:@"topic"]) {
        vc.dataDic = self.dataDic[@"author"];
    }else if([self.flagStr isEqualToString:@"top"]){ // top -> detail 的model
        vc.dataDic = nil;
        
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击like按钮
-(void)clickLikeBtn
{
    if (_likeView.likeBtn.selected) { // 点击前是selected状态
        [_likeView canselLike];
    }else{              // 点击前是未选中状态
        [_likeView isLike];
    }
    
    // 发送上一个界面的table需要刷表的通知    发送从数据库更新的通知  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LikeTableDidChanged" object:self];

}


#pragma mark - Notification
-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotice) name:@"no_more_product" object:nil];  /** 库存不足时的提醒view */
    
    /** NSNotificationCenter */
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyNumisChangedWithNotic:) name:@"buyNum_isChanged" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)showNotice
{
    //        NSLog(@"该商品库存不足啦~请选购其他商品吧");
    [self.view addSubview:[TipView showTheTipView]];
}





#pragma mark - 懒加载
-(UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-38)];
        _webView.delegate = self;
    }
    return _webView;
}
-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(30, (38-36)*0.5, 36, 36)];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:PLACEIMAGE];
        _imgView.clipsToBounds = YES;
        _imgView.layer.cornerRadius = 8;
    }
    return _imgView;
}
-(BuyView *)buyView
{
    if (!_buyView) {
        _buyView = [BuyView createWithShouldBuyNum:[self.dataDic[@"fnSaleNum"] integerValue] andFrame:CGRectMake(SCREENWIDTH-20-80, (38-25)*0.5, 80, 25)];
        _buyView.delegate= self;
        
//        NSLog(@"-------%ld",[self.dataDic[@"fnSaleNum"] integerValue]);
        
        _buyView.dataDic = self.dataDic;
        
        
        // 从数据库读取数据
        FMDBmanager *manager = [FMDBmanager shareInstance];
        //    NSString *idStr = [NSString stringWithFormat:@"%@",dic[@"fnId"]];
        NSString *sqlStr = [NSString stringWithFormat:@"select * from Car where idStr = '%@'",self.dataDic[@"fnId"]];
        //    NSLog(@"sqlString === %@",sqlStr);
        FMResultSet *rs = [manager.dataBase executeQuery:sqlStr];
        
        
        if ([rs next]) {// 如果数据库存在该数据   此处select结果只有一条
            
            _buyView.buyCountLabel.text = [NSString stringWithFormat:@"%@",[rs stringForColumn:@"buyNum"]];
            //        NSLog(@"lastBuyNum ===== %ld",cell.lastBuyNum);
        }else           // 如果数据库不存在该数据
        {
            
            if ([self.dataDic[@"fnSaleNum"] integerValue]) { // 有库存
                _buyView.buyCountLabel.text = @"0";
            }else                           // 已售罄
            {
                _buyView.addBtn.hidden = YES;
                _buyView.reduceBtn.hidden = YES;
                _buyView.buyCountLabel.text = @"已售罄";
                _buyView.buyCountLabel.textColor = [UIColor redColor];
            }
        }
    }
    return _buyView;
}
-(RedView *)redView
{
    if (!_redView) {
        
        _redView = [RedView shareRedView];
        _redView.frame = CGRectMake(SCREENWIDTH-100-10-2, 3, 20, 20);
        //**** 初始化 购物车总数 ****
        //**** 初始化 购物车总数 ****
        //    **** loadDataFromDB ****
        FMDBmanager *manager = [FMDBmanager shareInstance];
        NSString *sqlString = [NSString stringWithFormat:@"select buyNum from Car"];
        FMResultSet *rs = [manager.dataBase executeQuery:sqlString];
        NSInteger num = 0;
        while ([rs next]) {
            num = num + [rs intForColumn:@"buyNum"];
        }
        if (num) {
            //            vc3.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",num];
            self.redView.buyNum = num;
        }
    }
    return _redView;
}



#pragma mark - setter
-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    
//    NSLog(@"******");
    if ([self.flagStr isEqualToString:@"topic"]) {
        _myModel = [HomeModel buildModelWithDataDic:self.dataDic];
//        NSLog(@"_myModel.categoryStr === %@",_myModel.categoryStr);
    }else if([self.flagStr isEqualToString:@"top"]){ // top -> detail 的model
    
        _myModel = [HomeModel buildTOP10ModelWithDataDic:self.dataDic];
    
    }else if ([self.flagStr isEqualToString:@"db"]){
        /** 只有model，没有dataDic */
        // 不处理了
    }

}
@end
