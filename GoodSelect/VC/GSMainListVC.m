//
//  GSMainListVC.m
//  GoodSelect
//
//  Created by huangjinyang on 17/2/21.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//
#define TABLENAME @"goodselect"  //数据库表名
#define KEY_LIST @"list"
#define KHeaderHeight 180

#import "GSMainListVC.h"
#import "YYCache.h"
#import "UIScrollView+PullScale.h"
#import "GSSelectModel.h"
#import "GSHistoryCell.h"

@interface GSMainListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSMutableArray* dataList;
@end

@implementation GSMainListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"😋😋😋";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initTableView];
    [self initData];
    
    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//}

-(void)initData{
    self.dataList=[NSMutableArray new];
    self.dataList=[[LKDBHelper getUsingLKDBHelper] searchWithSQL:[NSString stringWithFormat:@"select * from %@",[GSSelectModel className]] toClass:[GSSelectModel class]];
    
}

#pragma mark - initUI

-(void)initTableView{
    self.tableView=[[UITableView alloc]init];
    self.tableView.frame=self.view.bounds;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.emptyDataSetSource=self;
    self.tableView.emptyDataSetDelegate=self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView=[UIView new];
//    [self.tableView addPullScaleFuncInVC:self originalHeight:KHeaderHeight hasNavBar:(self.navigationController!=nil)];
//    self.tableView.imageV.image=[UIImage imageNamed:@"test"];
}

#pragma mark - UITabelView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
//    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSHistoryCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[GSHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    GSSelectModel* model=self.dataList[indexPath.row];
    cell.model=model;
    CGFloat height=cell.cellHeight;
    return height;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSHistoryCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[GSHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    GSSelectModel* model=self.dataList[indexPath.row];
    cell.model=model;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself=self;
    GSSelectModel* selectModel=self.dataList[indexPath.row];
    [[LKDBHelper getUsingLKDBHelper]deleteWithClass:[GSSelectModel class] where:[NSString stringWithFormat:@"createdID = '%@'",selectModel.createdID] callback:^(BOOL result) {
        if (result) {
            
            }
    }];
    
    [MyTools showText:[NSString stringWithFormat:@"删除记录%@成功",selectModel.createdID] inView:weakself.view];
    [weakself.dataList removeObjectAtIndex:indexPath.row];
    [weakself.tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationLeft];
    [weakself.tableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - DZNEmpty

-(NSAttributedString* )titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSAttributedString* attStr=[[NSAttributedString alloc]initWithString:@"快点添加，哼~😒"];
    return attStr;
}

-(UIImage* )imageForEmptyDataSet:(UIScrollView *)scrollView{
    UIImage* image=[UIImage imageNamed:@"heiheihei"];
    image=[image scaleWithFixedWidth:100];
    image=[image scaleWithFixedHeight:100];
    return image;
}

-(CAAnimation* )imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CAKeyframeAnimation *animationx = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animationx.duration = 0.2;
    animationx.removedOnCompletion = YES;
    animationx.fillMode = kCAFillModeForwards;
    animationx.repeatCount = MAX_CANON;
    int directionx = arc4random() % 2;
    if (directionx == 0) {
        animationx.values = @[@(0),@(-M_PI / 50),@(0),@(M_PI / 50),@(0)];
    }else{
        animationx.values = @[@(0),@(M_PI / 50),@(0),@(-M_PI / 50),@(0)];
    }
    
    return animationx;
}

-(BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
