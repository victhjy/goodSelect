//
//  GSSettingCell.h
//  GoodSelect
//
//  Created by huangjinyang on 17/2/22.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSSettingCell : UITableViewCell

@property(nonatomic,strong)YYTextView* textView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
