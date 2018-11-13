//
//  ViewController.m
//  SQLITE3练习
//
//  Created by @刘珂 on 2018/4/27.
//  Copyright © 2018年 @刘珂. All rights reserved.
//

#import "ViewController.h"
#import "databaseHandle.h"
#import "InsertViewController.h"
#import "databaseModel.h"
#import "UpdateViewController.h"
@interface ViewController ()

@property (nonatomic , strong) NSArray *arrayDate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//更新数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化
    UpdateViewController *update = [[UpdateViewController alloc]init];
    
    //将本页面数据传到下一页面模型上
    update.model = _arrayDate[indexPath.row];
    
    //跳转
    [self.navigationController pushViewController:update  animated:YES];
}

//删除数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView == tableView)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            //获取数据库文件
            databaseHandle *dbHandle = [databaseHandle dbFileWithDbName:@"StudentList"];
            
            databaseModel *model = _arrayDate[indexPath.row];
            
            [dbHandle deleteDate:model.number];
            
            //重新查询数据
            _arrayDate = [dbHandle selectDate];
            
            [tableView reloadData];
        }
    }
}

//添加数据
- (IBAction)NextAction:(id)sender
{
    InsertViewController *insert = [[InsertViewController alloc]init];
    
    [self.navigationController pushViewController:insert animated:YES];
}

//查询数据
- (void)viewDidAppear:(BOOL)animated
{
    //获取数据库文件
    databaseHandle *dbHandle = [databaseHandle dbFileWithDbName:@"StudentList"];
    
    self.arrayDate = [dbHandle selectDate];
    
    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayDate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusble = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusble];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:reusble];
    }
    
    databaseModel *model = _arrayDate[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"姓名:%@\n年龄:%ld",model.name,model.age];
    
    cell.textLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"number：%ld",model.number];
    
    
    return cell;
}


@end
