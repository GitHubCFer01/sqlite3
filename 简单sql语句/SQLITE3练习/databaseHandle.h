//
//  databaseHandle.h
//  SQLITE3练习
//
//  Created by @刘珂 on 2018/4/27.
//  Copyright © 2018年 @刘珂. All rights reserved.
//

#import <Foundation/Foundation.h>
@class databaseModel;
@interface databaseHandle : NSObject

@property (nonatomic , copy) NSString *databaseName;

+ (instancetype)dbFileWithDbName:(NSString *)dbName;

- (void)insertData:(databaseModel *)student;

- (NSArray <databaseModel *> *)selectDate;

- (void)deleteDate:(NSInteger)number;

- (void)updateStudentListName:(NSString *)name byNumber:(NSInteger)number;
@end
