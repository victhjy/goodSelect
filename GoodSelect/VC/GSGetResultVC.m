//
//  GSGetResultVC.m
//  GoodSelect
//
//  Created by huangjinyang on 17/3/1.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSGetResultVC.h"
#import "GSSelectModel.h"
#import "LGDrawer.h"
@interface GSGetResultVC (){
    UILabel* _leftLabel;
    UILabel* _rightLabel;
    UIImageView* _arrowView;
    NSInteger _randomNum;
}
@property(nonatomic,strong)UIImageView* xiong;
@property(nonatomic,strong)UIButton* actionBtn;
@end

@implementation GSGetResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    self.xiong=[[UIImageView alloc]initWithImage:[LGDrawer drawHeartWithImageSize:kImageSize
                                                                             size:kSize
                                                                           offset:kOffset
                                                                           rotate:kRotate
                                                                  backgroundColor:[UIColor clearColor]
                                                                        fillColor:[UIColor colorWithRed:1.f green:0.f blue:0.3 alpha:1.f]
                                                                      strokeColor:kStrokeColor
                                                                  strokeThickness:kStrokeThickness
                                                                       strokeDash:kStrokeDash
                                                                      shadowColor:kShadowColor
                                                                     shadowOffset:kShadowOffset
                                                                       shadowBlur:kShadowBlur]];
    [self.view addSubview:self.xiong];
    self.xiong.frame=CGRectMake(0, 0, 400, 400);
    self.xiong.center=self.view.center;
    self.xiong.mj_y+=60;
    self.xiong.layer.masksToBounds=YES;
    self.xiong.layer.cornerRadius=self.xiong.width/2;
    
    
    self.actionBtn=[[UIButton alloc]init];
    self.actionBtn.frame=CGRectMake(0, 0, 70, 30);
    [self.view addSubview:self.actionBtn];
    self.actionBtn.layer.masksToBounds=YES;
    self.actionBtn.layer.cornerRadius=8;
    [self.actionBtn setTitle:@"开始吧" forState:UIControlStateNormal];
    self.actionBtn.backgroundColor=ThemeColor;
    self.actionBtn.titleLabel.textColor=[UIColor appNavigationBarColor];
    self.actionBtn.center=self.view.center;
    self.actionBtn.mj_y+=250;
    [self.actionBtn setTarget:self action:@selector(beginSwitch) forControlEvents:UIControlEventTouchUpInside];
    
    _leftLabel=[UILabel new];
    [self.view addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+34);
        make.centerX.equalTo(self.view.mas_left).offset(UIScreenWidth/4);
        make.width.equalTo(@(UIScreenWidth/4));
        make.height.equalTo(@50);
    }];
    _leftLabel.textAlignment=1;
    _leftLabel.numberOfLines=0;
    _leftLabel.text=[NSString stringWithFormat:@"l:\n%@",self.gsModel.l];
    
    _rightLabel=[UILabel new];
    [self.view addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+34);
        make.centerX.equalTo(self.view.mas_right).offset(-UIScreenWidth/4);
        make.width.equalTo(@(UIScreenWidth/4));
        make.height.equalTo(@50);
    }];
    _rightLabel.textAlignment=1;
    _rightLabel.numberOfLines=0;
    _rightLabel.text=[NSString stringWithFormat:@"h:\n%@",self.gsModel.h];
    
    
    _arrowView=[[UIImageView alloc]initWithImage:[LGDrawer drawArrowTailedWithImageSize:kImageSize
                                                                                   size:kSize
                                                                                 offset:kOffset
                                                                                 rotate:kRotate
                                                                              thickness:kThinckness*0.66/4
                                                                              direction:0
                                                                        backgroundColor:kBackgroundColor
                                                                                  color:kFillColor
                                                                                   dash:nil
                                                                            shadowColor:kShadowColor
                                                                           shadowOffset:kShadowOffset
                                                                             shadowBlur:kShadowBlur]];
    _arrowView.size=CGSizeMake(400, 400);
    _arrowView.center=self.view.center;
    _arrowView.mj_y+=60;
    [self.view addSubview:_arrowView];
    [self.view bringSubviewToFront:_arrowView];
}

-(void)pop{
    NSMutableArray<NSNumber*>*  arr =[@[@2,@5,@3,@8,@4,@6,@1,@10,@12] mutableCopy];
    for (int i=0; i<arr.count-1; i++) {
        for (int k=0; k<arr.count-i-1; k++) {
            if (arr[k]<arr[k+1]) {
                NSNumber* temp=arr[k];
                arr[k]=arr[k+1];
                arr[k+1]=temp;
            }
        }
    }
//    NSLog(@"pop     %@",arr);
    
    
    
    NSMutableArray<NSNumber*>*  arr2 =[@[@2,@5,@3,@8,@4,@6,@1,@10,@12] mutableCopy];
    for (int i=0; i<arr.count-1; i++) {
        for(int k=i;k<arr.count-1;k++){
            if (arr2[k]<arr2[i]) {
                NSNumber* temp=arr2[k];
                arr2[k]=arr2[i];
                arr2[i]=temp;
            }
        }
    }
//    NSLog(@"select    %@",arr2);
    
    
}
-(void)beginSwitch{
    
    
    [self pop];
    
    
    self.actionBtn.enabled=NO;
    [self.actionBtn setTitle:@"正在转" forState:UIControlStateNormal];
    NSInteger turnedAngle; //n个角度
    _randomNum = arc4random()%100; //随机概率
    NSInteger turnsNum = arc4random()%5 + 4; //控制圈数
    
    if (_randomNum>=50) {
        turnedAngle=arc4random()%180;
    }
    else{
        turnedAngle=180+arc4random()%180;
    }
    
    CGFloat perAngle = M_PI/180.0;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnedAngle * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_arrowView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_arrowView.layer animationForKey:@"rotationAnimation"])
    {
        self.actionBtn.enabled=YES;
        [self.actionBtn setTitle:@"开始吧" forState:UIControlStateNormal];
        
        if (_randomNum>50) {
            self.gsModel.result=@"h";
            [MyTools showText:[NSString stringWithFormat:@"%@ %@ %@ !",self.gsModel.h,self.gsModel.h,self.gsModel.h] inView:self.view];
        }
        else{
            self.gsModel.result=@"l";
            [MyTools showText:[NSString stringWithFormat:@"%@ %@ %@ !",self.gsModel.l,self.gsModel.l,self.gsModel.l] inView:self.view];
        }
    }
    NSString* currentDate=[MyTools dateStringYYYYMMDDFromNSDate:[NSDate date]];
    self.gsModel.currentDate=currentDate;
    
    NSString* cutString=[[currentDate substringWithRange:NSMakeRange(0, 10)] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSMutableArray* allDate = [[LKDBHelper getUsingLKDBHelper] search:[GSSelectModel class] where:[NSString stringWithFormat:@"createdID like '%%%@%%'",cutString] orderBy:@"currentDate" offset:0 count:1000];
    self.gsModel.createdID=[NSString stringWithFormat:@"%@-%ld",cutString,allDate.count+1];
    [self.gsModel saveToDB];
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
