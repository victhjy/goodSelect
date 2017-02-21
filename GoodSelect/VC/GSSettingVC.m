//
//  GSSettingVC.m
//  GoodSelect
//
//  Created by huangjinyang on 17/2/21.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSSettingVC.h"

@interface GSSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UISegmentedControl* segment;
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation GSSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(void)initUI{
    self.segment=[[UISegmentedControl alloc]initWithItems:@[@"♀♂",@"###"]];
    self.segment.frame=CGRectMake(0, 0, UIScreenWidth/3, 35);
    self.segment.center=self.navigationController.navigationBar.center;
    self.segment.tintColor = [UIColor appNavigationBarColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                               NSForegroundColorAttributeName: [UIColor lightTextColor]};
    [self.segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    self.segment.selectedSegmentIndex=0;
    [self.segment addTarget:self action:@selector(switchedStatus:) forControlEvents:UIControlEventValueChanged];
    self.navigationController.navigationBar.topItem.titleView=self.segment;
}

-(void)initTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor=self.view.backgroundColor;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView=[UIView new];
}

#pragma mark - switchedStatus

-(void)switchedStatus:(UISegmentedControl* )seg{
//    if (seg.selectedSegmentIndex==0) {
//        <#statements#>
//    }
//    else{
//        
//    }
    [self.tableView reloadData];
}

#pragma mark - UITabelView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(NSString* )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"l:";
    }
    else if (section==1){
        return @"h:";
    }else{
        return nil;
    }
}
-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UITextView* f=[UITextView new];
        f.frame=cell.frame;
        [cell addSubview:f];
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
