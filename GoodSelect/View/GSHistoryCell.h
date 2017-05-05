//
//  GSHistoryCell.h
//  GoodSelect
//
//  Created by huangjinyang on 17/4/13.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSSelectModel;
@interface GSHistoryCell : UITableViewCell
@property(nonatomic,strong)GSSelectModel* model;
@property(nonatomic,assign)CGFloat cellHeight;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
