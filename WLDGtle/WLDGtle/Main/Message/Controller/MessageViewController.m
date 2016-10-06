//
//  MessageViewController.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "MessageViewController.h"
#import "ScrollView.h"
#import "Common.h"
#import "WXRefresh.h"
@interface MessageViewController (){
    ScrollView *_sc;


}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopView];
    _sc = [[ScrollView alloc]initWithFrame:self.view.bounds];;
    _sc.backgroundColor = [UIColor redColor];
    _sc.delegate = self;
////    _sc.scrollEna
//    _sc.a
    [self.view addSubview:_sc];
//
//    UIViewController *a = self;
      
    // Do any additional setup after loading the view.
}





- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem.title = @"消息";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_inbox@2x"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_inbox_act@2x"];
        
        //        self.tabBarItem.
    }
    return self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadTopView{

    NSArray *arr = @[@"评论",@"赞",@"私信"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
//    view.backgroundColor = [UIColor redColor];
    for (NSInteger i = 0; i<3; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(i * 50 , 0, 50, 44);
//        [self.navigationItem.titleView addSubview:b];
//        self.navigationItem.titleView =
        [view  addSubview:b];
        b.tag = i + 100;
        [b setTitle:arr[i] forState:UIControlStateNormal];
        [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [b addTarget:self action:@selector(actionBut:) forControlEvents:UIControlEventTouchUpInside];
        [b setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        if (i== 0) {
            b.selected = YES;
        }
        
    }
    self.navigationItem.titleView = view;
    

}
- (void)actionBut:(UIButton *)b{
    
    
    b.selected = YES;
    [self showTitleColor:b];
    if (b.tag == 100) {
        [_sc setContentOffset:CGPointMake(0, 0)animated:YES];
        
        
    }if (b.tag == 101) {
        [_sc setContentOffset:CGPointMake(320, 0)animated:YES];
    }if (b.tag == 102) {
        [_sc setContentOffset:CGPointMake(640, 0)animated:YES];
    }



}
- (void)showTitleColor:(UIButton *)b{
    
    for (UIButton *subB in self.navigationItem.titleView.subviews) {
        if (subB != b) {
            subB.selected = NO;
        }
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIButton *b = [self.navigationItem.titleView viewWithTag:scrollView.contentOffset.x / 320 +100];
    b.selected = YES;
    
    [self showTitleColor:b];

}

//
//- (void)loadMyView{
//    for (NSInteger i = 0; i<3; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 50, kScreenWidth, kScreenHeight)];
//        view.backgroundColor = [UIColor yellowColor];
////        [self addSubview:view];
//    }
//    
//    
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (void)loadMyView{
//    for (NSInteger i = 0; i<3; i++) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 50, kScreenWidth, kScreenHeight)];
//        NSLog(@"%f",view.frame.origin.x);
//        view.backgroundColor = [UIColor yellowColor];
//        [_sc addSubview:view];
//        _sc.contentSize =CGSizeMake(kScreenWidth * 3 , 44);
//        
//    }
//    
//    
//    
//}



@end
