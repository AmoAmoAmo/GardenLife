//
//  YiJianViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/5.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "YiJianViewController.h"

@interface YiJianViewController ()<UITextViewDelegate>
/** 是否需要清空placeText的标记 */
@property (nonatomic, assign)BOOL flag;

@end

@implementation YiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"意见反馈";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"在线客服" style:UIBarButtonItemStyleDone target:nil action:nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    self.view.backgroundColor = AUTOCOLOR;
    self.automaticallyAdjustsScrollViewInsets= NO;
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBarTintColor:nil];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setUI
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + 64, SCREENWIDTH-30, 50)];
    label.text = @"您的批评和建议能帮助我们更好完善产品，清留下您的宝贵意见！";
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    
    NSArray *arr = @[@"软件功能",@"商品种类",@"商品品质",@"售后服务",@"配送服务",@"其他问题"];
    CGFloat margin = 10;
    CGFloat maxX = 20;
    CGFloat maxY = CGRectGetMaxY(label.frame)+15;
    CGFloat btnWidth = (SCREENWIDTH - maxX*2 - margin*2)/3.0;
    CGFloat btnHeight = 35;
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        int x = i < 3 ? i : (i-3); // 每行的第几个  列
        int y = i < 3 ? 0 : 1;     // 第几行       行
        btn.frame = CGRectMake(maxX + (btnWidth+margin)*x, maxY + (btnHeight+margin)*y, btnWidth, btnHeight);
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"mw1"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        
        btn.clipsToBounds= YES;
        btn.layer.cornerRadius = btnHeight * 0.5;
        btn.layer.borderWidth = .6f;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.view addSubview:btn];
    }
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(maxX, maxY + (btnHeight*2+margin) + 15, SCREENWIDTH-maxX*2, 100)];
    textView.clipsToBounds = YES;
    textView.layer.cornerRadius = 6;
    textView.layer.borderWidth = .7f;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.text = @"您的意见是我们的最大动力";
    textView.textColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:14];

    textView.delegate = self;
    [self.view addSubview:textView];

    
    
}

-(void)clickBtn:(UIButton*)btn
{
    for (int i = 100; i < 106; i++) {
        UIButton *subBtn = [self.view viewWithTag:i];
        subBtn.selected = NO;
    }
    btn.selected = YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.center = CGPointMake(SCREENWIDTH*0.5, SCREENHEIGHT*0.5);
    }];
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    /** 解决键盘遮挡问题 */
    /** 键盘默认高度 */
    CGFloat KeyBoardHeight = 216;
    /** 键盘上面的文字view，默认高度大约在38左右 */
    CGFloat textHeight = 40;
    // 计算需要让self.view.center偏移的 偏移量
    CGFloat offsetY = CGRectGetMaxY(textView.frame) - (SCREENHEIGHT-KeyBoardHeight-textHeight);
    
    if (offsetY > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.center = CGPointMake(SCREENWIDTH*0.5, SCREENHEIGHT*0.5-offsetY);
        }];
    }
    
    
    
    if (self.flag != 1) {
        textView.text = @"";
        self.flag = 1;
    }
    textView.textColor = [UIColor blackColor];
}



@end
