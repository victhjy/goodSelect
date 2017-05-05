//
//  DBHelper.m
//  SmartCard
//
//  Created by zhangke on 15/3/30.
//  Copyright (c) 2015年 深圳腾华兄弟互联技术有限公司. All rights reserved.
//

#import "DBHelper.h"

@implementation DBHelper

+(DBHelper *)sharedHelper
{
    static DBHelper *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^
                  {
                      instance = [[self alloc] init];
                  });
    
    return instance;
}

//插入
- (void)insertObj:(id)obj
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    [mdbHelper insertToDB:obj];
}

//删除
-(BOOL)deleteObj:(id)obj//删除单个
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    BOOL result = [mdbHelper deleteToDB:obj];
    if (result)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return YES;
}
-(BOOL)deleteSome:(id)modelClass condition:(NSString*)dition
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    BOOL result = [mdbHelper deleteWithClass:[modelClass class] where:dition];
    if (result)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return YES;
}
-(BOOL)deleteAllOjb:(id)modelClass//删除全部
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    BOOL result = [mdbHelper deleteWithClass:[modelClass class] where:nil];
    if (result)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    return YES;
}

//更新
-(void)updateObj:(id)obj condition:(NSString*)dition
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    [mdbHelper updateToDB:obj where:dition];
}

//查询
-(NSMutableArray*)queryObj:(id)modelClass condition:(NSString*)dition//查询部分
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    NSMutableArray *results = [mdbHelper search:
                               [modelClass class] where:dition orderBy:nil offset:0 count:0];
    
    return results;
}

-(NSMutableArray*)queryAllObj:(id)modelClass//查询全部
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    NSMutableArray *results = [mdbHelper search:
                               [modelClass class] where:nil orderBy:nil offset:0 count:0];
    
    return results;
}

-(NSMutableArray*)queryWithSQL:(id)modeClass SQL:(NSString*)sql
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    NSMutableArray *results = [mdbHelper searchWithSQL:sql toClass:[modeClass class]];
    
    return results;
}

-(BOOL)isObjExist:(id)modelClass condition:(NSString*)dition
{
    mdbHelper = [LKDBHelper getUsingLKDBHelper];
    return [mdbHelper isExistsClass:[modelClass class] where:dition];
}

@end
