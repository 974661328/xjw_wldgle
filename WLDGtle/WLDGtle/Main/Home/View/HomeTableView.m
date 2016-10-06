//
//  HomeTableView.m
//  WLDGtle
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "HomeTableView.h"
#import "Common.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "YYModel.h"
#import "HomeModel.h"
#import "ArticleTableViewCell.h"
#import "TransViewController.h"
#import "HomeViewController.h"
static CGFloat numPage;
//#import "MJRefresh.h"
#import "MJRefresh.h"
#define screenW kScreenWidth
#define screenH kScreenHeight
//#define numImageCount 4
@implementation HomeTableView{

    CGFloat numImageCount;
    NSMutableArray *_picArr;
    NSMutableArray *_titleArr;
    NSMutableArray *_modelArr;
//    UIScrollView *scrollView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTimer];
        numPage = 20;
        self.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        self.sectionFooterHeight = 0;
        self.delegate = self;
        self.dataSource = self;
        _picArr = [NSMutableArray array];
        _titleArr = [NSMutableArray array];
        _modelArr = [NSMutableArray array];
        
        //        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        //        [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=diydata&apikeys=DGTLECOM_APITEST1&bid=274&charset=UTF8&dataform=json&inapi=yes&modules=portal&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //            NSDictionary *dic = responseObject;
        ////            NSLog(@"dic:%@",dic);
        //            NSDictionary *dic2 = dic[@"returnData"][@"blocklist"][@"274"];
        //            NSArray *arr = [dic2 allValues];
        //
        //            numImageCount = arr.count;
        ////            NSLog(@"count:%i",arr.count);
        //            for (NSInteger i = 0; i<arr.count; i++) {
        //                NSDictionary *dic = arr[i];
        //                NSString *str =  dic[@"pic_url"];
        //                [_picArr addObject:str];
        //
        ////                NSString *str2 = dic[@"fulltitle"];
        ////                [_titleArr addObject:str2];
        //
        //                [self addTimer];
        //                [self reloadData];
        //
        //            }
        //
        //        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //            NSLog(@"%@",error.localizedDescription);
        //        }];
        //
        //        [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=0_20&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //
        //
        //
        //        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //
        //        }];
        [self firstRequest];
        
        //        [self createHttpRequest];
        
        
        self.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
             NSMutableArray *totalArr = [NSMutableArray array];
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=0_20&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSDictionary *dic = responseObject;
                //        NSLog(@"%@",dic);
                
                NSDictionary *dic2 = dic[@"returnData"][@"articlelist"];
                
                NSArray *arr = [dic2 allValues];

                for (NSInteger i =0; i<arr.count; i++) {
                    
                    NSDictionary *mydic = arr[i];
                    HomeModel *model = [HomeModel yy_modelWithDictionary:mydic];

                    [totalArr addObject:model];
                }
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, totalArr.count)];
                HomeModel *home1 = totalArr.firstObject;
                HomeModel *home2 = _modelArr.firstObject;
                if (!( home1.title == home2.title)) {
                    
                    [_modelArr insertObjects:totalArr atIndexes:set];
                }
                
                
//                NSLog(@"==%li",_modelArr.count);
                [self reloadData];
                
                [self.header endRefreshing];
                
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
        
            
            
            
            }
             ];
            
        }];
        
        self.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            
            
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
        
     
            NSString *str =  [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=%f_%f&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.0.5",numPage,numPage+20];
            
            [manage GET:str parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                
                
                
                NSDictionary *dic = responseObject;
                //        NSLog(@"%@",dic);
                
                NSDictionary *dic2 = dic[@"returnData"][@"articlelist"];
                
                NSArray *arr = [dic2 allValues];
                //        NSLog(@"%@",arr);
                for (NSInteger i =0; i<arr.count; i++) {
                    
                    
                    NSDictionary *mydic = arr[i];
                    //            NSLog(@"=================%@",[dic allKeys]);
                    
                    HomeModel *model = [HomeModel yy_modelWithDictionary:mydic];
                    //                    [_modelArr addObject:model];
                    [_modelArr insertObject:model atIndex:_modelArr.count];
                    [self reloadData];
                    [self.footer endRefreshing];
                }
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                
            }];
        }
            
            
        ];
        
        
        
        
        
        
        
//        
//             NSString *str =  [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=%f_%f&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.0.5",numPage,numPage+20];
    //
    //
    //            [manage GET:str parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    //
    //
    //
    //                NSDictionary *dic = responseObject;
    //                //        NSLog(@"%@",dic);
    //
    //                NSDictionary *dic2 = dic[@"returnData"][@"articlelist"];
    //
    //                NSArray *arr = [dic2 allValues];
    //                //        NSLog(@"%@",arr);
    //                for (NSInteger i =0; i<arr.count; i++) {
    //
    //
    //                    NSDictionary *mydic = arr[i];
    //                    //            NSLog(@"=================%@",[dic allKeys]);
    //
    //                    HomeModel *model = [HomeModel yy_modelWithDictionary:mydic];
    ////                    [_modelArr addObject:model];
    //                    [_modelArr insertObject:model atIndex:_modelArr.count];
    //                    [self reloadData];
    //                    [self.footer endRefreshing];
    //                }
    //
    //                
    //            } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //                
    //                
    //            }];
    //
    //            
    //        }];
    //
  }
    return self;

}
- (void)firstRequest{

    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];

    [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=diydata&apikeys=DGTLECOM_APITEST1&bid=274&charset=UTF8&dataform=json&inapi=yes&modules=portal&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
        //            NSLog(@"dic:%@",dic);
        NSDictionary *dic2 = dic[@"returnData"][@"blocklist"][@"274"];
        NSArray *arr = [dic2 allValues];
        numImageCount = arr.count;
        
        
        
        for (NSInteger i = 0; i<arr.count; i++) {
            NSDictionary *dic = arr[i];
            NSString *str =  dic[@"pic_url"];
            [_picArr addObject:str];
            
            //                NSString *str2 = dic[@"fulltitle"];
            //                [_titleArr addObject:str2];
            
//            [self addTimer];
            [self reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
    [self createHttpRequest];
//    [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=0_20&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];



}
- (void)createHttpRequest{
    
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=article&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&limit=0_20&modules=portal&order=dateline_desc&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = responseObject;
//        NSLog(@"%@",dic);
        
        NSDictionary *dic2 = dic[@"returnData"][@"articlelist"];
        
        

        
        
        NSMutableArray *arr = [dic2 allValues].mutableCopy;
        [self getSmallDate:arr];
        

        
        
//        for (NSDictionary *modDic in arr) {
//            
//            HomeModel *model = [HomeModel yy_modelWithDictionary:modDic];
//            
//            
//        }
        
        
        
        
        

        
        for (NSInteger i =0; i<arr.count; i++) {


            
            NSDictionary *mydic = arr[i];

            HomeModel *model = [HomeModel yy_modelWithDictionary:mydic];
//            NSLog(@"xjwmodel:%@",model.title);
            [_modelArr addObject:model];
            
        }
        [self reloadData];
        
//        NSLog(@"==%li",_modelArr.count);
//        NSLog(@"aadsd%@",[(HomeModel *)_modelArr[0] title]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];




}
- (void)getSmallDate:(NSMutableArray *)arr{
//    HomeModel *hm = arr[0];
//    for(NSInteger i = 1; i < arr.count;i++ ){
//        HomeModel *hm2 = arr[i];
//        
//    
//    }
    for (NSInteger i = 0; i < [arr count]; i++) {
        for (NSInteger j = i+1; j<arr.count; j++) {
            NSDictionary  *homeM = [arr objectAtIndex:i];
            HomeModel *model = [HomeModel yy_modelWithDictionary:homeM];

            NSDictionary *homeM2 = [arr objectAtIndex:j];
            HomeModel *model2 = [HomeModel yy_modelWithDictionary:homeM2];

            if ([model.dateline integerValue]< [model2.dateline integerValue]) {
                [arr replaceObjectAtIndex:i withObject:homeM2];
                [arr replaceObjectAtIndex:j withObject:homeM];
                
            }
            
            
            
        }
    }




}
//- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
//    self = [super initWithFrame:frame style:style];
//    if (self) {
//        
//        self.delegate = self;
//        self.dataSource = self;
//        _picArr = [NSMutableArray array];
//        _titleArr = [NSMutableArray array];
//        
//        AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//        [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?actions=diydata&apikeys=DGTLECOM_APITEST1&bid=274&charset=UTF8&dataform=json&inapi=yes&modules=portal&platform=ios&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSDictionary *dic = responseObject;
//            NSDictionary *dic2 = dic[@"blocklist"][@"274"];
//            NSArray *arr = [dic2 allValues];
//            numImageCount = arr.count;
//            for (NSInteger i = 0; i<arr.count; i++) {
//                NSDictionary *dic = arr[i];
//               NSString *str =  dic[@"pic_url"];
//                [_picArr addObject:str];
//                
//                NSString *str2 = dic[@"fulltitle"];
//                [_titleArr addObject:str2];
//                [self reloadData];
//                
//            }
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error.localizedDescription);
//        }];
//        
//    }
//    return self;
//
//
//}
//

- (void)createTopView{
//    UIScrollView *scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    CGFloat scrollViewW = screenW - 10;
//    scrollView.frame = CGRectMake(5, 5, scrollViewW,180);
    CGFloat scrollViewW = screenW ;
    scrollView.frame = CGRectMake(0, 0, scrollViewW,180);

    scrollView.contentSize = CGSizeMake(scrollViewW*numImageCount, 0);
    //    scrollView.contentInset = UIEdgeInsetsMake(20, 20, 0, 20);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
//    NSLog(@"aasdsd%@",self.scrollView);
    
    for (int i = 0; i < numImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        CGFloat imageViewY = 0;
        CGFloat imageViewW = scrollViewW;
        CGFloat imageViewH = 200;
        CGFloat imageViewX = i * imageViewW;
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        [self.scrollView addSubview:imageView];
//        NSString *name = [NSString stringWithFormat:@"function_guide_%d",i+1];
        NSString *name = _picArr[i];

//        imageView.image = [UIImage imageNamed:name];
        [imageView sd_setImageWithURL:[NSURL URLWithString:name]];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    CGFloat pageW = 60;
    CGFloat pageH = 30;
    CGFloat pageX = screenW /2- pageW/2;
    CGFloat pageY = 160;
    pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    //设置pagecontrol的总页数
    pageControl.numberOfPages = 5;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    self.pageControl = pageControl;
//    [self.scrollView addSubview:pageControl];
//    [self addTimer];





}



-(void)playImage
{

    int page = 0;
    if (self.pageControl.currentPage == numImageCount-1) {
        page = 0;
    }else{
    
        
        page = self.pageControl.currentPage +1;
    }

    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        
        CGFloat scrollW = scrollView.frame.size.width;
        CGFloat width = scrollView.contentOffset.x;
        int page = (width  + scrollW * 0.5) / scrollW;
        self.pageControl.currentPage = page;
    }
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {

    [self.timer invalidate];
    self.timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (![scrollView isKindOfClass:[UITableView class]]) {

    [self addTimer];
    
    }
    
}

-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(playImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{

    return _modelArr.count + 1;

}              // Default is 1 if not implemented




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 0){
    
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        
//        NSLog(@"=======%@",self.scrollView);
//        _scrollView.backgroundColor= [UIColor redColor];

        [self createTopView];
        [cell.contentView addSubview:_scrollView];
        [cell.contentView addSubview:_pageControl];
        

        
        return cell;
    }else{
    
        ArticleTableViewCell *artCell = [tableView dequeueReusableCellWithIdentifier:@"art"];
        if (artCell == nil) {
//            artCell  = [[ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"art"];
        
            artCell = [[[NSBundle mainBundle]loadNibNamed:@"ArticleTableViewCell" owner:self options:nil]lastObject];
            
        }
        artCell.homeModel = _modelArr[indexPath.section-1];
        
        return artCell;
    
    }
    
    



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 180;
    }
    else{
        
        return 256;
    
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
      HomeModel *hm =   _modelArr[indexPath.row];
    NSString *str = hm.fromurl;
    
    NSString *appS = [NSString stringWithFormat:@"http://www.dgtle.com/%@",str];
//    NSLog(@"adasdadasddadasdasdasdasd,%@",appS);
    TransViewController *tra = [[TransViewController alloc]init];
    [tra loadWebView:appS];
    
    HomeViewController *hmc = (HomeViewController *) [self viewController];
    [hmc.navigationController pushViewController:tra animated:YES];
    



}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
