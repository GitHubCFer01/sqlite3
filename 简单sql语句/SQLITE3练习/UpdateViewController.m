//
//  UpdateViewController.m
//  SQLITE3练习
//
//  Created by @刘珂 on 2018/4/27.
//  Copyright © 2018年 @刘珂. All rights reserved.
//

#import "UpdateViewController.h"
#import "databaseHandle.h"
@interface UpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@end

@implementation UpdateViewController

- (IBAction)backAction:(id)sender{
    //获取数据库文件
    databaseHandle *dbHandle = [databaseHandle dbFileWithDbName:@"StudentList"];
    //修改
    [dbHandle updateStudentListName:self.nameTF.text byNumber:self.model.number];
    //返回上一页面
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
