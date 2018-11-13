//
//  InsertViewController.m
//  SQLITE3练习
//
//  Created by @刘珂 on 2018/4/27.
//  Copyright © 2018年 @刘珂. All rights reserved.
//

#import "InsertViewController.h"
#import "databaseHandle.h"
#import "databaseModel.h"
@interface InsertViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@end

@implementation InsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backAction:(id)sender{
    databaseHandle *dbHandle = [databaseHandle dbFileWithDbName:@"StudentList"];
    databaseModel *model = [[databaseModel alloc]init];
    //赋值
    model.name = self.nameTF.text;
    model.age  = [self.ageTF.text integerValue];
    model.number = [self.numberTF.text integerValue];
    [dbHandle insertData:model];
    [self.navigationController popViewControllerAnimated:YES];
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
