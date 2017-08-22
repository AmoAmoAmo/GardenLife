//
//  MenuViewController.m
//  GardenLife
//
//  Created by Jane on 16/5/6.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "MenuViewController.h"
#import "QuestionsModel.h"
#import "QuesHeadView.h"
#import "AnswerCell.h"
#import "SectionHeadView.h"
#import "AllViewController.h"
#import "SelectedViewController.h"

@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray *dataArr;
/** 记录选中section */
@property (nonatomic,assign) NSInteger lastOpenIndex;
/** 记录当前（实时点击的那个section）cell状态  */
@property (nonatomic,assign) BOOL isOpenCell;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) QuesHeadView *lastHeadView;

@property (nonatomic,strong) UIView *bottonView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.lastOpenIndex = -1;
    self.isOpenCell = NO;
    self.isSelected = NO;
    [self setUI];
}

-(void)setUI
{
    [self.view addSubview:self.table];
    [self.view addSubview:self.bottonView];
//    if (self.flag == 1) {
//        self.table.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-49);
//    }
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
        NSMutableArray *arr = [NSMutableArray arrayWithObject:deleteIndexPath];
        
        NSDictionary *dic = self.dataArr[self.lastOpenIndex];
        NSArray *childArr = dic[@"childrenList"];
        if (childArr.count > 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:self.lastOpenIndex];
            [arr addObject:indexPath];
        }
        //        NSLog(@"%@",arr[0]);
        [self.table deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    if (self.lastOpenIndex == section && self.isOpenCell) {  // 两次点的是同一个section，都没有
        //        NSLog(@"两次点的是同一个section");
        // 计算删除行
        NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.lastOpenIndex];
        NSMutableArray *arr = [NSMutableArray arrayWithObject:deleteIndexPath];
        
        NSDictionary *dic = self.dataArr[self.lastOpenIndex];
        NSArray *childArr = dic[@"childrenList"];
        if (childArr.count > 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:self.lastOpenIndex];
            [arr addObject:indexPath];
        }
        
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
    NSMutableArray *array = [NSMutableArray arrayWithObject:deleteIndexPath];
    
    NSDictionary *dic = self.dataArr[self.lastOpenIndex];
    NSArray *childArr = dic[@"childrenList"];
    if (childArr.count > 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:self.lastOpenIndex];
        [array addObject:indexPath];
    }
    
    // 插入行
    [self.table insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationTop];
}



#pragma mark - UITableViewDataSource
// 返回段头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.flag == 1)
    {  // home menu
        return 0;
        
    }else
    {    // 商城 menu
        return 80;
    }
    
}
// 返回段头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.flag == 1)
    {  // home menu
        return nil;
        
    }else
    {    // 商城 menu
        //    QuesHeadView *headView = [[QuesHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        SectionHeadView *headView = [[SectionHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 80)];
        //    NSLog(@"************************");
        
        NSDictionary *dic = self.dataArr[section];
        [headView.titleL setText:dic[@"fnName"]];
        
        
        //    headView.index = section;
        headView.tag = section;
        headView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSection:)];
        [headView addGestureRecognizer:tap];
        
        return headView;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.flag == 1)
    {  // home menu
        return 1;
        
    }else
    {    // 商城 menu
        return self.dataArr.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{//按钮点击后 lastOpenIndex isOpenCell 改变，刷表
    
    if (self.flag == 1)
    {  // home menu
        return self.dataArr.count;
        
    }else
    {    // 商城 menu
        if (self.lastOpenIndex == section && self.isOpenCell) {
            
            NSDictionary *dic = self.dataArr[section];
            NSArray *arr = dic[@"childrenList"];
            return arr.count;
        }
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 1)
    {  // home menu
        return 40;
        
    }else
    {    // 商城 menu
        if (self.lastOpenIndex == indexPath.section && self.isOpenCell) {
            
            //        QuestionsModel *model = self.dataArr[indexPath.section];
            //        return model.cellHeight;
            return 40;
        }
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    QuestionsModel *model = self.dataArr[indexPath.section];
//    AnswerCell *cell = [AnswerCell cellWithTableView:tableView andDatamodel:model];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor colorWithRed:223/255.0 green:221/255.0 blue:223/255.0 alpha:0.3];
    
    if (self.flag == 1)
    {  // home menu
        cell.textLabel.text = self.dataArr[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        
    }else
    {    // 商城 menu
        NSDictionary *dic = self.dataArr[indexPath.section];
        NSArray *arr = dic[@"childrenList"];
        NSDictionary *tempDic = arr[indexPath.row];
        cell.textLabel.text = tempDic[@"fnName"];
    }
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == 1)
    {  // home menu
        SelectedViewController *VC = [[SelectedViewController alloc] init];
        VC.nameStr= self.dataArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else
    {    // 商城 menu
        NSDictionary *dic = self.dataArr[indexPath.section];
        NSArray *arr = dic[@"childrenList"];
        NSDictionary *tempDic = arr[indexPath.row];
        //    tempDic[@"fnId"];
        
        AllViewController *vc = [[AllViewController alloc] init];
        vc.idStr = tempDic[@"fnId"];
        vc.flag = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}




#pragma mark - setter and getter
//懒加载
-(UITableView *)table
{
    if (_table == nil)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT-64-49-40) style:UITableViewStylePlain];//style:UITableViewStylePlain(默认 设置分组有悬浮)
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
      
        _dataArr = [NSMutableArray array];
        
        if (self.flag == 1)
        {  // home menu
            _dataArr = [NSMutableArray arrayWithObjects:@"家居庭院",@"缤纷小物",@"植物百科",@"花田秘籍",@"跨界鉴赏",@"城市微光", nil];
            
        }else
        {    // 商城 menu
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Tree" ofType:nil];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            _dataArr = dic[@"result"];
        }
    }
    return _dataArr;
}

-(UIView *)bottonView
{
    if (!_bottonView) {
        _bottonView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-64-49-50, SCREENWIDTH, 50)];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        lineV.alpha = 0.6;
        [_bottonView addSubview:lineV];
        
        UIView *lineV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREENWIDTH, 1)];
        lineV2.backgroundColor = [UIColor lightGrayColor];
        lineV2.alpha = 0.4;
        [_bottonView addSubview:lineV2];
        
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5+3, SCREENWIDTH, 15)];
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.textColor = [UIColor darkGrayColor];
        lab1.font = [UIFont systemFontOfSize:13];
        lab1.text = @"FLORAL&LIFE";
        [_bottonView addSubview:lab1];
        
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5+15+3, SCREENWIDTH, 15)];
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.textColor = [UIColor darkGrayColor];
        lab2.font = [UIFont systemFontOfSize:12];
        lab2.text = @"-  花田小憩  -";
        [_bottonView addSubview:lab2];
    }
    return _bottonView;
}

@end
