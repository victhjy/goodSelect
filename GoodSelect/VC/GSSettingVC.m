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

@interface GSSettingVC ()<YYTextViewDelegate>
{
    NSMutableArray* heightArr;
}
@property(nonatomic,strong)UISegmentedControl* segment;
@end

@implementation GSSettingVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
    [self initTableView];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    heightArr=[@[@36,@36,@36] mutableCopy];
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
    
    UIBarButtonItem* rightItem=[[UIBarButtonItem alloc]initWithTitle:@"历史" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}

-(void)initTableView{
    WEAKSELF;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.userInteractionEnabled=YES;
    [self.tableView.backgroundView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.view endEditing:YES];
    }];
    self.tableView.tableFooterView=[self footerView];
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
    NSNumber* number=heightArr[indexPath.section];
    CGFloat f=[number floatValue];
    
    return f;
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
    cell.textView.delegate=self;
    cell.textView.tag=1016+indexPath.section;
    cell.textView.frame=cell.contentView.bounds;
    switch (indexPath.section) {
        case 0:
            cell.textView.placeholderText=@"什么问题呢";
            break;
        case 1:
            cell.textView.placeholderText=@"一般是对的";
            break;
        case 2:
            cell.textView.placeholderText=@"一般是错的";
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)closeKeyboard{
    [self.view endEditing:YES];
}

#pragma mark - YYTextViewDelegate

-(void)textViewDidChange:(YYTextView *)textView{
    switch (textView.tag-1016) {
        case 0:
            heightArr[0]=[NSNumber numberWithFloat:[textView sizeThatFits:CGSizeMake(UIScreenWidth, CGFLOAT_MAX)].height];
            textView.height=[textView sizeThatFits:CGSizeMake(UIScreenWidth, CGFLOAT_MAX)].height;
            [UIView setAnimationsEnabled:NO];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            [UIView setAnimationsEnabled:YES];
            [textView becomeFirstResponder];
            break;
        case 1:
            heightArr[1]=[NSNumber numberWithFloat:[textView sizeThatFits:CGSizeMake(UIScreenWidth, CGFLOAT_MAX)].height];
            textView.height=[textView sizeThatFits:CGSizeMake(UIScreenWidth, CGFLOAT_MAX)].height;
            [UIView setAnimationsEnabled:NO];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            [UIView setAnimationsEnabled:YES];
            [textView becomeFirstResponder];
            break;
        case 2:
            heightArr[2]=[NSNumber numberWithFloat:[textView sizeThatFits:CGSizeMake(UIScreenWidth, CGFLOAT_MAX)].height];
            textView.height=[textView sizeThatFits:CGSizeMake(UIScreenWidth, CGFLOAT_MAX)].height;
            [UIView setAnimationsEnabled:NO];
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            [UIView setAnimationsEnabled:YES];
            [textView becomeFirstResponder];
            break;
            
        default:
            break;
    }
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
