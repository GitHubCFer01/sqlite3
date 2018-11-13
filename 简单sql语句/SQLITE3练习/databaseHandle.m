//
//  databaseHandle.m
//  SQLITE3练习
//
//  Created by @刘珂 on 2018/4/27.
//  Copyright © 2018年 @刘珂. All rights reserved.
//

#import "databaseHandle.h"
#import <sqlite3.h>
#import "databaseModel.h"
//3.创建sqilte3实例
static sqlite3 *db;

@implementation databaseHandle

//1.获取沙盒路径
- (NSString *)filePath{
    
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return file;
}

//2.给Caches文件下添加数据库文件
- (NSString *)dbFile{
    
    NSString *dbName = [self.databaseName stringByAppendingString:@".db"];
    NSString *file = [[self filePath]stringByAppendingPathComponent:dbName];
    return file;
}

//4.打开数据库
- (void)openDb{
    
    NSString *databaseFile = [self dbFile];
    int result = sqlite3_open([databaseFile UTF8String], &db);
    if (result == SQLITE_OK){
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}

//5.创建表
+ (instancetype)dbFileWithDbName:(NSString *)dbName{
    //初始化本类
    databaseHandle *dbHandle = [[databaseHandle alloc]init];
    //将参数赋值给本类
    dbHandle.databaseName = dbName;
    //获取数据库文件
    NSString *dbFile = [dbHandle dbFile];
    //打开数据库
    int result = sqlite3_open([dbFile UTF8String], &db);
    if (result == SQLITE_OK){
        //sql语句
        NSString *sql = @"create table if not exists StudentList(number integer primary key autoincrement , name text , age integer)";
        char *error = nil;
        //执行sql语句
        sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error);
        if (error != nil) {
            
            NSLog(@"错误在这呢：%s",error);
        }
    }else {
        NSLog(@"打开数据库失败");
    }
    
    return dbHandle;
}

//6.关闭数据库
- (void)closeDb{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK){
        NSLog(@"关闭数据库成功");
    }else {
        NSLog(@"关闭数据库失败");
    }
}

//插入数据
- (void)insertData:(databaseModel *)student{
    //打开数据库
    [self openDb];
    //sql语句
    NSString *sql = @"insert into StudentList(number , name , age)values(? , ? , ?)";
    sqlite3_stmt *stmt = nil;
    //执行并检验sql语句
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        //绑定数据
        sqlite3_bind_int(stmt, 1, (int)student.number);
        sqlite3_bind_text(stmt, 2, [student.name UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 3, (int)student.age);
        //执行语句
        sqlite3_step(stmt);
    }
    //释放内存
    sqlite3_finalize(stmt);
    //关闭数据库
    [self closeDb];
}

//查询数据
- (NSArray <databaseModel *> *)selectDate{
    //打开数据库
    [self openDb];
    //sql语句
    NSString *sql = @"select * from StudentList";
    sqlite3_stmt *stmt = nil;
    //执行sql语句
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSMutableArray *array = [NSMutableArray array];
    if (result == SQLITE_OK){
        NSLog(@"查询成功");
        //获取数据
        while (sqlite3_step(stmt) == SQLITE_ROW){
            //初始化模型
            databaseModel *model = [[databaseModel alloc]init];
            model.number = sqlite3_column_int(stmt, 0);
            model.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            model.age = sqlite3_column_int(stmt, 2);
            [array addObject:model];
        }
        
    }else {
        NSLog(@"查询失败");
    }
    
    return array;
}

//删除数据
- (void)deleteDate:(NSInteger)number{
    //打开数据库
    [self openDb];
    //sql语句
    NSString *sql = @"delete from StudentList where number = ?";
    sqlite3_stmt *stmt = nil;
    //执行并检验sql语句
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        //绑定数据
        sqlite3_bind_int(stmt, 1, (int)number);
        //执行语句
        sqlite3_step(stmt);
    }
    //释放内存
    sqlite3_finalize(stmt);
    //关闭数据库
    [self closeDb];
}

//更新数据
- (void)updateStudentListName:(NSString *)name byNumber:(NSInteger)number{
    //打开数据库
    [self openDb];
    //sql语句
    NSString *sql = @"update StudentList set name = ? where number = ?";
    sqlite3_stmt *stmt = nil;
    //执行sql语句
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK){
        //绑定数据
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, (int)number);
        //执行语句
        sqlite3_step(stmt);
    }
    //释放内存
    sqlite3_finalize(stmt);
    //关闭数据库
    [self closeDb];
}


@end
