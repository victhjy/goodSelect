//
//  GSSettingCell.m
//  GoodSelect
//
//  Created by huangjinyang on 17/2/22.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSSettingCell.h"

@implementation GSSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.textView=[[YYTextView alloc]init];
    [self.contentView addSubview:self.textView];
    self.textView.font=[UIFont systemFontOfSize:18];
//    self.textView.scrollEnabled=NO;
    self.textView.frame=self.contentView.bounds;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
