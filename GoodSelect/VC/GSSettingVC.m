//
//  GSSettingVC.m
//  GoodSelect
//
//  Created by huangjinyang on 17/2/21.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSSettingVC.h"
#import "GSMainListVC.h"
#import "GSSettingCell.h"
#import "GSTestCASjapeLayer.h"
#import "GSGetResultVC.h"
#import "GSSelectModel.h"
#import "GSChoiceModel.h"

@interface GSSettingVC ()<YYTextViewDelegate>
{
    NSMutableArray* heightArr;
    GSSelectModel* _gsModel;
}
@property(nonatomic,strong)UISegmentedControl* segment;
@property(nonatomic, strong) NSMutableArray *listArr;
@end

@implementation GSSettingVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
    [self initTableView];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _gsModel=[GSSelectModel new];
    self.listArr=[NSMutableArray new];
    
    GSChoiceModel* chancen=[GSChoiceModel new];
    chancen.onwer=@"n";
    
    GSChoiceModel* chanceh=[GSChoiceModel new];
    chanceh.onwer=@"h";
    
    GSChoiceModel* chancel=[GSChoiceModel new];
    chancel.onwer=@"l";
    
    [self.listArr addObject:chancen];
    [self.listArr addObject:chancel];
    [self.listArr addObject:chanceh];
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
    
    UIBarButtonItem* rightItem=[[UIBarButtonItem alloc]initWithTitle:@"历史" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}

-(void)initTableView{
    WEAKSELF;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.estimatedRowHeight = 36;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView=[self footerView];
    [self.tableView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself closeKeyboard];
    }];
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

-(void)rightItemClicked{
    GSMainListVC* listVC=[GSMainListVC new];
    [self.navigationController pushViewController:listVC animated:YES];
    
}

-(UIView* )footerView{
    UIView* bgView=[UIView new];
    bgView.frame=CGRectMake(0, 0, UIScreenWidth, 80);
    bgView.backgroundColor=self.tableView.backgroundColor;
    
    UIButton* b=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    b.layer.masksToBounds=YES;
    b.layer.cornerRadius=8;
    b.backgroundColor=ThemeColor;
    [b setTitle:@"action" forState:UIControlStateNormal];
    b.titleLabel.textColor=[UIColor appNavigationBarColor];
    [b addTarget:self action:@selector(showResult) forControlEvents:UIControlEventTouchUpInside];
    b.center=bgView.center;
    [bgView addSubview:b];
    return bgView;
}

-(void)showResult{
    if (_gsModel.question.length==0 || _gsModel.h.length==0 || _gsModel.l.length==0) {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"填完，傻逼" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action1=[UIAlertAction actionWithTitle:@"😯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alert addAction:action1];
        
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    else{
        GSGetResultVC* resultVC=[GSGetResultVC new];
        resultVC.gsModel=_gsModel;
        resultVC.title=_gsModel.question;
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}

#pragma mark - UITabelView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSChoiceModel* model= self.listArr[indexPath.row];

    return model.height;
}

-(NSString* )tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"O__O…";
    }
    else if (section==1) {
        return @"l:";
    }
    else if (section==2){
        return @"h:";
    }else{
        return nil;
    }
}
-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSSettingCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[GSSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.tableView=tableView;
    GSChoiceModel* model=self.listArr[indexPath.row];
    [cell dataBind:model];

    return cell;
}

-(void)closeKeyboard{
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
