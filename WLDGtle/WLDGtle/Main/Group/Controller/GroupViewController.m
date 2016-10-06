//
//  GroupViewController.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "GroupViewController.h"
#import "GScrollView.h"

#import "Common.h"


@interface GroupViewController ()<UIScrollViewDelegate>{
    UIView *_titleView;
    GScrollView *_gsv;

}

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GScrollView *gs  = [[GScrollView alloc]initWithFrame:self.view.bounds];
    gs.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    gs.pagingEnabled = YES;
    gs.delegate = self;
    _gsv = gs;
  // gs.alwaysBounceHorizontal = NO;
//    gs.alwaysBounceVertical   = NO;
//    gs.bounces = NO;
//    gs.pagingEnabled = YES;
//    gs.directionalLockEnabled= YES;
//    gs.
    [self.view addSubview:gs];
//    UICollectionViewFlowLayout *flv = [[UICollectionViewFlowLayout alloc]init];
//    GCollectionView *gcv= [[GCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flv];
//    
//    gcv.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
//    
////    gcv.contentOffset = CGPointMake(0, -100);
//    flv.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    
//    flv.minimumInteritemSpacing = 0.0f;
//    flv.minimumLineSpacing = 0;
//
//    gcv.pagingEnabled = YES;
    

    
    //[self.view addSubview:flv];

    
  //  NSLog(@"vvvvvvvvv%@",self.navigationController);
//    [self _ta];
    
    
    
    // Do any additional setup after loading the view.
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.tabBarItem.title = @"小组";
        self.tabBarItem.image = [UIImage imageNamed:@"tab_group@2x"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_group_act@2x"];
        
        [self _loadTitleView];
        
        

        
        
    }
    return self;
    
}
- (void)_loadTitleView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleView = view;
   // view.backgroundColor  =[UIColor greenColor];
    self.navigationItem.titleView = _titleView;
    
    CGFloat width = 200/2;
    for (NSInteger i = 0; i<2; i++) {
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, 44);
        if (i == 0) {
            
          //  button.titleLabel.text = @"精选";
            [button setTitle:@"精选" forState:UIControlStateNormal];
            
            
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
           // button.backgroundColor = [UIColor redColor];

        }else{
//            button.titleLabel.text = @"发现";
            [button setTitle:@"发现" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
//        button.backgroundColor = [UIColor grayColor];
        button.tag = i+100;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside]
        ;
//        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_titleView addSubview:button];
    }
}



//检测精选 发现
- (void)buttonAction:(UIButton *)butt{
    

    [butt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    if (butt.tag == 101) {
       [ _gsv setContentOffset:CGPointMake(320, 0)];
        
        
    }else{
    
        [_gsv setContentOffset:CGPointMake(0, 0)];
    }
    
 
    for (UIView *v in _titleView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *b = (UIButton *)v;
            if (b.tag != butt.tag) {
//                b.titleLabel.textColor = [UIColor grayColor];
                [b setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
        
        }
    }
}

//#warning 测试
//- (void)_ta{
//    
//    GTableView *tv = [[GTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    [self.view addSubview:tv];
//    
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (scrollView.contentOffset.x == 320) {
        UIButton *b = [self.navigationItem.titleView viewWithTag:1 + 100];
        [b setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        UIButton *b2 = [self.navigationItem.titleView viewWithTag:0 + 100];

        [b2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    }else if(scrollView.contentOffset.x == 0 )
    
    {
//        UIButton *b = [self.navigationItem.titleView viewWithTag:0];
//        [self buttonAction:b];
       
        UIButton *b = [self.navigationItem.titleView viewWithTag:0 +100];
        [b setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        UIButton *b2 = [self.navigationItem.titleView viewWithTag:1 + 100];
        
        [b2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    }


}






- (void)viewDidAppear:(BOOL)animated{

   // NSLog(@"%@",self.navigationController.navigationBar.subviews);

    

//    NSLog(@"%@", self.navigationItem.titleView);
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
