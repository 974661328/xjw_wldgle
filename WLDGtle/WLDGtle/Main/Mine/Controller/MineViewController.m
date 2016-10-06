//
//  MineViewController.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "MineViewController.h"
#import "WXRefresh.h"


@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tv = (UITableView *)self.view;
    tv.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
//    tv.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
//    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
 
    

}
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleLightContent;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_zone@2x"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_zone_act@2x"];
        
        //        self.tabBarItem.
    }
    return self;
    
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
