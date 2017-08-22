//
//  QuestionViewController.m
//  LoveFresh
//
//  Created by Jane on 16/4/12.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionsModel.h"
#import "QuesHeadView.h"
#import "AnswerCell.h"


@interface QuestionViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;
/** 记录选中section */
@property (nonatomic,assign) CGFloat lastOpenIndex;
/** 记录当前（实时点击的那个section）cell状态  */
@property (nonatomic,assign) BOOL isOpenCell;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) QuesHeadView *lastHeadView;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.lastOpenIndex = -1;
    self.isOpenCell = NO;
    self.isSelected = NO;
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
    self.title = @"常见问题";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"在线客服" style:UIBarButtonItemStyleDone target:nil action:nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.table];
    if (self.flag == 1) {
        self.table.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-49);
    }
}

#pragma mark - 点击
-(void)tapSection:(UITapGestureRecognizer *)tap
{
    QuesHeadView *headView = (id)tap.view;
    
    
//    NSLog(@"clickSection...");
    CGFloat section = headView.tag;
//    NSLog(@"section====%f",section);
    
    
//    if (self.lastOpenIndex == -1) //第一次点击的时候
    /**
        每当 self.table 调用的时候，table的代理都会刷表
     */
        
        
//        NSLog(@"lastOpenIndex===%f",self.lastOpenIndex);
    if (self.lastOpenIndex != section && self.isOpenCell) {// 两次点的不是同一个section,section选中
        self.isOpenCell = NO;
        [self.lastHeadView changeImgViewStateWithFlag:NO];// 将上一次的headView的flag 置NO
        // 计算删除行
        NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.lastOpenIndex];
        NSArray *arr = [NSArray arrayWithObject:deleteIndexPath];
//        NSLog(@"%@",arr[0]);
        [self.table deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (self.lastOpenIndex == section && self.isOpenCell) {  // 两次点的是同一个section，都没有
//        NSLog(@"两次点的是同一个section");
        // 计算删除行
        NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.lastOpenIndex];
        NSArray *arr = [NSArray arrayWithObject:deleteIndexPath];
//        NSLog(@"%@",arr[0]);
        self.isOpenCell = NO;
        [self.lastHeadView changeImgViewStateWithFlag:NO];
//        NSLog(@"78952");
        [self.table deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // 跳出  --> 没有插入  (只跳出一个循环)
        return;
    }
    
    [headView changeImgViewStateWithFlag:YES];
//    NSLog(@"78952");
    self.lastOpenIndex = section;
    self.lastHeadView = headView;
    self.isOpenCell = YES;
    // 计算插入行
    NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    NSArray *array = [NSArray arrayWithObject:deleteIndexPath];
    // 插入行
    [self.table insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
}



#pragma mark - UITableViewDataSource
// 返回段头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
// 返回段头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuesHeadView *headView = [[QuesHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
//    NSLog(@"************************");
    QuestionsModel *model = self.dataArr[section];
    [headView.titleL setText:model.questionStr];
//    headView.index = section;
    headView.tag = section;
    headView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSection:)];
    [headView addGestureRecognizer:tap];
    
    return headView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{//按钮点击后 lastOpenIndex isOpenCell 改变，刷表
    if (self.lastOpenIndex == section && self.isOpenCell) {
        return 1;
    }
    return 0;
}

//返回每个cell的高度，这里高度是固定的，可以直接写死, 如果高度是不固定的需要先调用estimatedHeightForRowAtIndexPath:方法给个预计高度
//等网络请求完毕后根据cell内容算出高度 再调用heightForRowAtIndexPath：设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.lastOpenIndex == indexPath.section && self.isOpenCell) {
        
        QuestionsModel *model = self.dataArr[indexPath.section];
        return model.cellHeight;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionsModel *model = self.dataArr[indexPath.section];
    AnswerCell *cell = [AnswerCell cellWithTableView:tableView andDatamodel:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];//style:UITableViewStylePlain(默认 设置分组有悬浮)
                _table.separatorStyle = UITableViewCellSeparatorStyleNone;//把table的线去掉
//        _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;

}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HelpPlist" ofType:@"plist"];
        NSArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *dic in arr) {
            
            QuestionsModel *model = [QuestionsModel setQuestionsModelWithDic:dic];
            [_dataArr addObject:model];
        }
    }
    return _dataArr;
}
@end
