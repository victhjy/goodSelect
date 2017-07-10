//
//  GSSettingCell.h
//  GoodSelect
//
//  Created by huangjinyang on 17/2/22.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSChoiceModel;
@interface GSSettingCell : UITableViewCell <YYTextViewDelegate>

@property(nonatomic,strong)YYTextView* textView;
@property(nonatomic, weak) GSChoiceModel *model;
@property(nonatomic, strong) UITableView *tableView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)dataBind:(GSChoiceModel* )model;
@end
