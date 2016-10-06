//
//  GFindTableView.m
//  WLDGtle
//
//  Created by mac on 16/8/22.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "GFindTableView.h"
#import "DataService.h"
#import "GFindTableModel.h"
#import "YYModel.h"
#import "Common.h"
#import "DgtleModel.h"
#import "FindCellLayout.h"
#import "GFindTableViewCell.h"
#import "cellLayout.h"
#import "GTableViewCell.h"
#import "WXRefresh.h"
#import "UIImageView+WebCache.h"
#import "GroupViewController.h"
#import "HotViewController.h"

#define kHeadViewHeight 0
#define kSpace 10
static NSInteger pushedButton = -MAXFLOAT;

static NSInteger pageNum = 2;
@implementation GFindTableView
{
    
    UIImageView *_topImgView;
    UIScrollView *_mediumScollView;
    
    NSMutableArray *_topImgArr;
    NSMutableArray *_laysArr;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (UIImageView *)topImgView{
//    if (_topImgView == nil) {
//        _topImgView = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    }
//    return _topImgView;
//}
- (NSMutableArray *)topImgArr{

    if (_topImgArr == nil) {
        _topImgArr = [NSMutableArray array];
    }
    return _topImgArr;

}

- (NSMutableArray *)laysArr{

    if (_laysArr == nil) {
        _laysArr = [NSMutableArray array];
    }
    return _laysArr;

}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.sectionHeaderHeight = 70;
        self.sectionFooterHeight = 0;
        GFindTableView *gt = self;

        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tongzhi:) name:@"xjwNot2" object:nil];
        
        [self addInfiniteScrollingWithActionHandler:^{
            
            [gt addInfiniteScrollingWithActionHandler];
            
            
        }];
        
    [DataService requestWithUrl:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&platform=ios&REQUESTCODE=49&swh=480x800&version=3.0.5"
    httpMethod:@"GET" params:nil fileData:nil success:^(id result) {
     DataService *d = [DataService shareDataService];
     d.tag = 0;
     [self requsetSuccess:result];
     [self reloadData];
 } failure:^(NSError *error) {
     NSLog(@"%@",error.localizedDescription);
     
 }];
        
    }
    
    
        [DataService requestWithUrl:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&page=1&perpage=20&platform=ios&REQUESTCODE=62&swh=480x800&version=3.0.5" httpMethod:@"GET" params:nil fileData:nil success:^(id result) {
            DataService *d = [DataService shareDataService];
            
            d.tag = 1;
            [self requsetSuccess:result];
            [self reloadData];
            
        } failure:^(NSError *error) {
            
        


        }];
    
    
    
    return self;
    

}


- (void)addInfiniteScrollingWithActionHandler{
  
//    DataService *d = [DataService shareDataService];
   
    NSString *str = [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&page=%li&perpage=20&platform=ios&REQUESTCODE=62&swh=480x800&version=3.0.5",pageNum];
    [DataService requestWithUrl:str httpMethod:@"GET" params:nil fileData:nil success:^(id result) {
        DataService *d = [DataService shareDataService];
        d.tag = 2;
        [self requsetSuccess:result];
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)requsetSuccess:(id)result{
    
    
    DataService *d = [DataService shareDataService];
    if (d.tag== 0) {
        
        NSDictionary *dic = result;

        NSArray *arr = dic[@"bannerlist"];
        
        
        for (NSDictionary *dic in arr) {
            GFindTableModel *model = [GFindTableModel yy_modelWithDictionary:dic];
            NSString *path = model.pic;
            

            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
            UIImage *img = [UIImage imageWithData:data];
            [self.topImgArr addObject:img];
            
            
        }
    }
    
    
    if (d.tag  == 1) {
        NSDictionary *dic = result;

        NSArray *arr = dic[@"returnData"][@"hotlist"];

        for (NSDictionary *dic in arr) {
            DgtleModel *model = [DgtleModel yy_modelWithDictionary:dic];
            cellLayout  *cellLay = [[cellLayout alloc]init];
            cellLay.gmodel = model;
            [self.laysArr addObject:cellLay];
            
        }

   
        
    }
    if (d.tag == 2) {
        NSDictionary *dic = result;
        
        NSArray *arr = dic[@"returnData"][@"hotlist"];
        
        for (NSDictionary *dic in arr) {
            
            DgtleModel *model = [DgtleModel yy_modelWithDictionary:dic];
            cellLayout  *cellLay = [[cellLayout alloc]init];
            



            cellLay.gmodel = model;
            [self.laysArr addObject:cellLay];
            
        }
        
    }
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1 ) {
        
        return 1;
        
    }else{
        
        return  _laysArr.count;
    
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{

    return 3;

}


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        _topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120 )];
        _topImgView.animationImages = _topImgArr;
//        NSLog(@"%@",_topImgArr);
        _topImgView.animationDuration = 2;
       // cell.backgroundColor = [UIColor redColor];
//        _topImgView.image = _topImgArr[0];
        [_topImgView startAnimating];
        [cell.contentView addSubview:_topImgView];
        return cell;
        
    }
    else if (indexPath.section == 1) {
        
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        _mediumScollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//        _mediumScollView.backgroundColor = [UIColor colorWithRed:239 green:239 blue:255 alpha:1];
//        _mediumScollView.backgroundColor = [UIColor colorWithRed:2 green:2 blue:2 alpha:1];
        _mediumScollView.backgroundColor = [UIColor grayColor];
       cell.backgroundColor = [UIColor colorWithRed:239 green:239 blue:244 alpha:1];
        _mediumScollView.contentSize = CGSizeMake(10 * 60 + 9 *kSpace, 0);
        _mediumScollView.showsHorizontalScrollIndicator = NO;
        [self createButtonInScollView];
        [cell.contentView addSubview:_mediumScollView];
        
        return cell;
        
    
    }else{
        
        GTableViewCell *cell =  nil;
        cell =[[[NSBundle mainBundle]loadNibNamed:@"GTableViewCell" owner:self options:nil] lastObject];
        cell.layout = _laysArr[indexPath.row];
        
        
        cell.layout.indexRow = indexPath.row;
        cell.tag = 1;
        
        
        
        return cell;
    }






}

- (void)createButtonInScollView{
    
//    for (NSInteger i = 0; i < 10 ; i++) {
//        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
//        b.frame = CGRectMake(60 * i + kSpace * (i + 1), kSpace, 60, 80);
//        b.backgroundColor = [UIColor blueColor];
//        [_mediumScollView addSubview:b];
//    
//    }
    
    NSArray *arr1 = @[@"http://s.dgtle.com/group/90/group_143_banner.png?1471252927",@"http://s.dgtle.com/group/0f/group_141_banner.png?1467289881",@"http://s.dgtle.com/group/13/group_140_banner.png?1467290309",
                      @"http://s.dgtle.com/group/e0/group_139_banner.png?1463451083",@"http://s.dgtle.com/group/7f/group_135_banner.png?1467876177"];
    NSArray *arr2 = @[@"http://s.dgtle.com/group/90/group_143_pngico.png?1471252927",@"http://s.dgtle.com/group/0f/group_141_pngico.png?1467289881",@"http://s.dgtle.com/group/13/group_140_pngico.png?1467289530",@"http://s.dgtle.com/group/e0/group_139_pngico.png?1463387779",@"http://s.dgtle.com/group/7f/group_135_pngico.png?1463380173"];
    NSArray *arr3 = @[@"玩具控",@"尾巴生活",@"摄影控",@"电脑控",@"智能设备"];
        for (NSInteger i = 0; i < 5 ; i++) {
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            b.frame = CGRectMake(140 * i + kSpace * (i + 1), kSpace, 140, 160);
            b.backgroundColor = [UIColor whiteColor];
            [_mediumScollView addSubview:b];
            
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 140, 120)];
            UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(140/2 - 50/2, 120 - 50/2 - 10, 50, 50)];
            
            [imgV sd_setImageWithURL:[NSURL URLWithString:arr1[i]]];
            imgV2.layer.cornerRadius = 25;
            [imgV2.layer masksToBounds];
            [imgV2 sd_setImageWithURL:[NSURL URLWithString:arr2[i]]];
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(140/2 - 100/2, CGRectGetMaxY(imgV2.frame)+10, 100, 13)];
            lable.text = arr3[i];
            lable.textAlignment = NSTextAlignmentCenter;
            [b addSubview:lable];
            lable.font = [UIFont systemFontOfSize:10];
            
            [b addSubview:imgV];
            [b addSubview:imgV2];
        
        }
    
    
    

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 120;
    }
    
    if (indexPath.section== 1) {
      
        return 200;
    }
    
    
    
    
    cellLayout *cellLay =   _laysArr[indexPath.row];
    return   cellLay.cellHeight;
    



}
- (void)tongzhi:(NSNotification *)not{
    
    
    NSInteger a =   [not.userInfo[@"row"] integerValue];
    
    pushedButton = a;
    //    [self dataserviceRequest:1];
    NSInteger i = 0;
    NSMutableArray *array = [NSMutableArray array];
    //    NSLog(@"+%@",_tv.layoutArr);
    for (cellLayout *lay in self.laysArr) {
        
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
    
//    _tv.layoutArr = array;
    _laysArr = array;
    //    NSLog(@"%@",_tv.layoutArr);
    
    //    []
    
    [self reloadData];
    
    
    
    
    
    
    //    [self dataserviceRequest:downPage];
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    if (section == 1) {
        view = [[NSBundle mainBundle]loadNibNamed:@"HeadViewSecond" owner:self options:nil].lastObject;
        
        
    }if (section == 2) {
        view = [[NSBundle mainBundle]loadNibNamed:@"HeadViewSubView" owner:self options:nil].lastObject;
        UIButton *b = [view viewWithTag:101];
        [b addTarget:self action:@selector(bAction:) forControlEvents:UIControlEventTouchUpInside];
        


    }
    view.backgroundColor = [UIColor clearColor];
    return view;
    

}
//
- (void)bAction:(UIButton *)b{
    NSLog(@"点击");
   GroupViewController *gcv = (GroupViewController *) [self viewController:b];
    HotViewController *hot = [[HotViewController alloc]init];
    hot.view.backgroundColor = [UIColor redColor];
    
        
    [gcv.navigationController pushViewController:hot animated:YES];
    
    
    



}
- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



@end
