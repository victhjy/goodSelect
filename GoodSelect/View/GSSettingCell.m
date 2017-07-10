//
//  GSSettingCell.m
//  GoodSelect
//
//  Created by huangjinyang on 17/2/22.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import "GSSettingCell.h"
#import "GSChoiceModel.h"
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
    self.textView.delegate=self;
    self.textView.scrollEnabled=NO;
    self.textView.frame=CGRectMake(5, 0, YYScreenSize().width, CGFLOAT_MAX);
}
-(void)dataBind:(GSChoiceModel* )model{
    self.model=model;
    self.textView.text=model.content;
}

-(void)textViewDidChange:(YYTextView *)textView{
    self.textView.text=textView.text;
    NSDictionary *dic = @{NSFontAttributeName:self.textView.font};
    CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(UIScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    [self.tableView beginUpdates];
    if (textSize.width<UIScreenWidth) {
        textSize.width=UIScreenWidth;
    }
    textView.mj_size=textSize;
    self.model.height=textSize.height+10;
    [self.tableView endUpdates];
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
