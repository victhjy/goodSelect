//
//  GSSelectModel.h
//  GoodSelect
//
//  Created by huangjinyang on 17/3/27.
//  Copyright © 2017年 huangjinyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSSelectModel : NSObject

@property(nonatomic,strong)NSString* currentDate;  ///<产生选择结果的时间
@property(nonatomic,strong)NSString* h;
@property(nonatomic,strong)NSString* l;
@property(nonatomic,strong)NSString* question;
@property(nonatomic,strong)NSString* result;  ///<字符串类型，h 或者 l
@property(nonatomic,strong)NSString* createdID;  ///<20170501-01的格式

@end
