//
//  GSHistoryCell.m
//  GoodSelect
//
//  Created by huangjinyang on 17/4/13.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSHistoryCell.h"
#import "GSSelectModel.h"

@interface GSHistoryCell ()

@property(nonatomic,strong)UILabel* question;
@property(nonatomic,strong)UILabel* result;
@property(nonatomic,strong)UILabel* rightItem;
@property(nonatomic,strong)UILabel* wrongItem;
@property(nonatomic,strong)UILabel* currentDate;
@property(nonatomic,strong)UILabel* createdID;



@end


@implementation GSHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.question=[UILabel new];
    self.question.numberOfLines=0;
    self.question.textAlignment=1;
    self.question.font=[UIFont systemFontOfSize:18];
    
    self.result=[UILabel new];
    self.result.numberOfLines=0;
    
    self.rightItem=[UILabel new];
    self.rightItem.numberOfLines=0;
    
    self.wrongItem=[UILabel new];
    self.wrongItem.numberOfLines=0;
    
    self.currentDate=[UILabel new];
    
    self.createdID=[UILabel new];
    self.createdID.textAlignment=2;
    
    
    
    [self.contentView addSubview:self.question];
    [self.contentView addSubview:self.result];
    [self.contentView addSubview:self.rightItem];
    [self.contentView addSubview:self.wrongItem];
    [self.contentView addSubview:self.currentDate];
    [self.contentView addSubview:self.createdID];

    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(UIScreenWidth-20);
        make.centerX.mas_equalTo(self.contentView);
    }];
    [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.question.mas_bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(UIScreenWidth-20);
    }];
    [self.wrongItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightItem);
        make.top.equalTo(self.rightItem.mas_bottom).offset(5);
        make.width.equalTo(self.rightItem);
    }];
    [self.result mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.equalTo(self.wrongItem.mas_bottom);
    }];
    
    [self.createdID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightItem);
        make.top.equalTo(self.result.mas_bottom).offset(5);
    }];
    [self.currentDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.createdID);
    }];
}

-(CGFloat)cellHeight{
    return self.currentDate.frame.origin.y+self.currentDate.frame.size.height+10;
}


-(void)setModel:(GSSelectModel *)model{
    self.question.text=model.question;
    BOOL isH;
    if ([model.result isEqualToString:@"h"]) {
        isH=YES;
        self.result.text=[NSString stringWithFormat:@"h is right"];
    }
    else{
        isH=NO;
        self.result.text=[NSString stringWithFormat:@"l is right"];
    }
    self.rightItem.text=[NSString stringWithFormat:@"✅:%@",isH?model.h:model.l];
    self.wrongItem.text=[NSString stringWithFormat:@"❎:%@",isH?model.l:model.h];
    self.createdID.text=model.createdID;
    self.currentDate.text=model.currentDate;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self updateConstraints];
    [self layoutIfNeeded];
}

@end
