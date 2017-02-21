//
//  GSListHeaderView.m
//  GoodSelect
//
//  Created by huangjinyang on 17/2/21.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSListHeaderView.h"

@implementation GSListHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(UIView* )headerView{
    UIView* bgView=[UIView new];
    bgView.backgroundColor=ThemeColor;
    bgView.frame=CGRectMake(0, 0, UIScreenWidth, 120);
    
    return bgView;
}

@end
