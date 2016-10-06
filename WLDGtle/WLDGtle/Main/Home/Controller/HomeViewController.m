//
//  HomeViewController.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_home@2x"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_home_act@2x"];
       // NSLog(@"nnnnnnnn:%@",self.navigationController);
//        self.tabBarItem.
//        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 618)];
//        imgV.image = [UIImage imageNamed:@"menu_logo@3x"];
//        
//        self.navigationItem.titleView = imgV;
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        [b setImage:[UIImage imageNamed:@"menu_logo@3x"] forState:UIControlStateNormal];
        b.frame = CGRectMake(0, 0, 44, 44);
        self.navigationItem.titleView = b ;
    
    }
    return self;

}


//- (void)createTitleVie

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
