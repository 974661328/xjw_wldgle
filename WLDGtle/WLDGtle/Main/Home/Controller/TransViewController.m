//
//  TransViewController.m
//  WLDGtle
//
//  Created by mac on 16/9/9.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "TransViewController.h"

@interface TransViewController ()

@end

@implementation TransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)loadWebView:(NSString *)urlString{

    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:urlString];
    web.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];


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
