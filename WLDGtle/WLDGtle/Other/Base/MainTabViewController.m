//
//  MainTabViewController.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "MainTabViewController.h"
#import "BaseNavController.h"
#import "Common.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self removeSubViews];
    [self loadSubviewControllter];
    
    
    // Do any additional setup after loading the view.
}
- (void)loadSubviewControllter{
    NSArray *array = @[@"Home",@"Group",@"Message",@"Mine"];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *str in array) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:str bundle:nil];
        BaseNavController *nav = [story instantiateInitialViewController];
        [arr addObject:nav];
        
    }
    self.viewControllers = arr;
    



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
