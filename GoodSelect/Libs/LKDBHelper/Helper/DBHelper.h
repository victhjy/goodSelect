//
//  DBHelper.h
//  SmartCard
//
//  Created by zhangke on 15/3/30.
//  Copyright (c) 2015年 深圳腾华兄弟互联技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"


@interface DBHelper : NSObject
{
    LKDBHelper *mdbHelper;
}

+(DBHelper *)sharedHelper;

//插入
- (void)insertObj:(id)obj;

//删除
-(BOOL)deleteObj:(id)obj;//删除单个
-(BOOL)deleteAllOjb:(id)modelClass;//删除全部
-(BOOL)deleteSome:(id)modelClass condition:(NSString*)dition;//删除部分

//修改
-(void)updateObj:(id)obj condition:(NSString*)dition;

//查询
-(NSMutableArray*)queryObj:(id)modelClass condition:(NSString*)dition;//查询部分
-(NSMutableArray*)queryAllObj:(id)modelClass;//查询全部
-(BOOL)isObjExist:(id)modelClass condition:(NSString*)dition;   //查询元素是否存在
-(NSMutableArray*)queryWithSQL:(id)modeClass SQL:(NSString*)sql; //按照SQL来查询，比如查询数据库前10条数据，上面两个方法是做不到的，因为是where条件查询语句，而不是SQL查询
@end
