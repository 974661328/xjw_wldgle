//
//  GScrollView.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "GScrollView.h"
#import "GTableView.h"
#import "GFindTableView.h"
#import "Common.h"
#import "WXRefresh.h"
#import "DataService.h"
#import "cellLayout.h"
#import "YYModel.h"
static NSInteger pushedButton = -MAXFLOAT;

static NSInteger downPage = 1;
//static NSInteger upPage = 1;

@implementation GScrollView{
   
    GTableView *_tv;
    GFindTableView *_gtv;
    DataService *_dataS;

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
    if (self) {
        
        _tv = [[GTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [self addSubview:_tv];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tongzhi:) name:@"xjwNot" object:nil];
        
//        _gtv = [[GFindTableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        _gtv = [[GFindTableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _gtv.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        [self addSubview:_gtv];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator =NO;

        self.bounces = NO;
        self.contentSize = CGSizeMake(kScreenWidth * 2 , 0);
        
        

       
        //第一次加载
        [self dataserviceRequest:1];
        //下拉刷新
        GScrollView *sv = self;
       
        [_tv addPullDownRefreshBlock:^{
            
            [sv addPullDownRefresh];
        
        
        }];
        
        //上拉加载
        [_tv addInfiniteScrollingWithActionHandler:^{
            
            [sv addInfiniteScrollingWithActionHandler];
            
        
        }];
        
        
        
    
    }
    return self;

}

- (void)tongzhi:(NSNotification *)not{
    
    
    NSInteger a =   [not.userInfo[@"row"] integerValue];

    pushedButton = a;
//    [self dataserviceRequest:1];
    NSInteger i = 0;
   NSMutableArray *array = [NSMutableArray array];
//    NSLog(@"+%@",_tv.layoutArr);
    for (cellLayout *lay in _tv.layoutArr) {
        
        cellLayout *lay2 = [[cellLayout alloc]init];

        if (i == pushedButton) {
           
            
            lay2.isClick = YES;
//            lay.buttonFrame = CGRectZero;
//            lay.gmodel = [DgtleModel yy_modelWithDictionary:<#(nonnull NSDictionary *)#>]
            
        }else{
            
            
        }
        lay2.gmodel = lay.gmodel;
        [array addObject:lay2];
        i++;
    }

    _tv.layoutArr = array;
//    NSLog(@"%@",_tv.layoutArr);
    
//    []

    [_tv reloadData];
    
    
    
    
    
    
//    [self dataserviceRequest:downPage];


}
//第一次请求封装
//-------------------------------------
- (void)dataserviceRequest:(NSInteger)i{
    
    NSString *str = [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&digest=1&inapi=yes&page=%li&perpage=10&platform=ios&REQUESTCODE=46&swh=480x800&version=3.0.5",i];
 [DataService requestWithUrl:str httpMethod:@"GET" params:nil fileData:nil success:^(id result)
                            {
      
                                

        DataService *dataSer = [DataService shareDataService];
                            
        dataSer.tag = 0;
                                
        [self requestSuccess:result];
    
    } failure:^(NSError *error) {
        NSLog(@"-----%@",error.localizedDescription);
    }];
    
// gFindTableView
//    NSString *str = [NSString stringWithFormat:@""]
    
    
    
    

}


//下拉刷新
- (void)addPullDownRefresh{
    
    DataService *dataSer = [DataService requestWithUrl:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&digest=1&inapi=yes&page=1&perpage=10&platform=ios&REQUESTCODE=46&swh=480x800&version=3.0.5" httpMethod:@"GET" params:nil fileData:nil success:^(id result) {
        [self requestSuccess:result];
       
        dataSer.tag = 1;

    } failure:^(NSError *error) {
        
        NSLog(@"=====%@",error.localizedDescription);
        
    }
  ];
//    downPage += 1;


}
//上拉加载
- (void)addInfiniteScrollingWithActionHandler{
    

//    DataService *da = [DataService shareDataService];
//    NSLog(@"aaaaaaaa%@",da);
    downPage += 1;

    NSString *str = [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&digest=1&inapi=yes&page=%li&perpage=10&platform=ios&REQUESTCODE=46&swh=480x800&version=3.0.5",downPage];
    
 [DataService requestWithUrl:str httpMethod:@"GET" params:nil fileData:nil success:^(id result)
                          
    {
        
//        NSLog(@"---%@",dataS);
        
        DataService *dataS = [DataService shareDataService];
        dataS.tag = 2;
        [self requestSuccess:result];
//        
        
    } failure:^(NSError *error) {
        NSLog(@"+++++%@",error.localizedDescription);
    }];
    
}
- (void)protocalXjw:(NSInteger)a{

    pushedButton = a;

    [self dataserviceRequest:downPage];

}

//请求成功
- (void)requestSuccess:(id)result{
   
    DataService *dataS = [DataService shareDataService];


    
    
    NSDictionary *dic = result;
   

    NSArray *arr = dic[@"newlist"];
    
    
    NSInteger i = 0;
    
    NSMutableArray *totalArr = [NSMutableArray array];
   
    for (NSDictionary *model in arr) {
        

        cellLayout *layout = [[cellLayout alloc]init];
        
        
        if (i == pushedButton) {
            
            layout.isClick = YES
            
            ;
            
            
            
        }
        layout.gmodel = [DgtleModel yy_modelWithDictionary:model];
        [totalArr addObject:layout];
        
        i++;
        
        
    }

    if (dataS.tag == 0) {
    
        
        _tv.layoutArr = totalArr;
   
    
    }
    //下拉
    
    if (dataS.tag == 1) {
        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, totalArr.count)];
        
        [_tv.layoutArr insertObjects:totalArr atIndexes:set];
        
        //结束下拉刷新
        
        [_tv.pullToRefreshView stopAnimating];
        
        

    }
    //上拉加载
    if (dataS.tag == 2) {
        
        //cellLayout *cl =  _tv.layoutArr.lastObject;

    

//        [_tv.layoutArr addObjectsFromArray:totalArr];
       [_tv.layoutArr addObjectsFromArray:totalArr];


        [_tv.infiniteScrollingView stopAnimating];
        
        
    }
    
    [_tv reloadData];
    

    

}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    _tv.scrollEnabled = NO;
//    
////    NSLog(@"%@huadong",scrollView);
//
//}

@end
