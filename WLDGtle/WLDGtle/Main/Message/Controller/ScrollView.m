//
//  ScrollView.m
//  WLDGtle
//
//  Created by mac on 16/8/26.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "ScrollView.h"
#import "Common.h"
#import "MainViewController.h"
//#import "WXRefresh.h"
#import "MJRefresh.h"
//#import "MainViewController.h"

@implementation ScrollView{

    
    NSTimer *_timer;
    NSInteger _time;
    UIScrollView *_scv;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if ( self) {
        
    self.contentSize =CGSizeMake(kScreenWidth * 3 , 0);
//        NSLog(@"%@",self);
        [self loadMyView];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = YES;
    }
    return self;


}
- (NSMutableArray *)setPullImage{
//    UIImageView *imgView = [[UIImageView alloc]init];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 1; i< 11; i++) {
        
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"whale%li",i]];
        [arr addObject:img];
    }
//    imgView.animationImages = arr;
//    imgView.animationDuration = 3;
//    [imgView startAnimating];
    
    return arr;
    
    
    
    
}

- (void)loadMyView{


    for (NSInteger i = 0; i<3; i++) {
        
//        if (i == 0) {
//            view2.frame = CGRectMake(i * kScreenWidth, 50, kScreenWidth, kScreenHeight);
//
//        }
//        UISegmentedControl *seg = [UISegmentedControl ]
        UIScrollView *view2 = [[UIScrollView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        if (i == 0) {
            NSArray *items = @[@"我收到的评论",@"我发出的评论"];
            UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:items];
            seg.frame = CGRectMake((kScreenWidth - 180)/2, 10, 180, 20);
            seg.selectedSegmentIndex = 0;
            seg.tintColor = [UIColor grayColor];
            seg.segmentedControlStyle = UISegmentedControlStyleBar;
            [view2 addSubview:seg];
//            NSLog(@"bbb");
//            MJRefreshNormalHeader *head = [MJRefreshNormalHeader ]
//            view2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//                
//
//
//            } ];

            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            [header setImages:[self setPullImage] forState:MJRefreshStateRefreshing];
            header.lastUpdatedTimeLabel.hidden = YES;
            header.stateLabel.hidden = YES;
            view2.mj_header = header;
            _scv = view2;

            
            
        }
        view2.contentSize = CGSizeMake(0, kScreenHeight+100);
//        if (i == 2) {
//            MainViewController *mail= [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
////            view2 =
//           UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
//
//            view2 = mail.view;
//
//        }
//
        
        view2.backgroundColor = [UIColor yellowColor];
        if (i == 1) {
            view2.backgroundColor = [UIColor greenColor];
        }
        [self addSubview:view2];

    }
    
    
    
}
- (void)loadNewData{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    _time = 3;
    




}
- (void)timeAction{

    _time--;
    if (_time == 0) {
        [_scv.mj_header endRefreshing];
        [_timer invalidate];
    }
    

}




@end
