//
//  HotViewController.m
//  WLDGtle
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "HotViewController.h"
#import "HotTableView.h"
@interface HotViewController ()

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"随便看看";
    [self createTableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTableView{
    
    HotTableView *htv = [[HotTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:htv];


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
