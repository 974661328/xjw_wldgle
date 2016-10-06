//
//  HotTableView.m
//  WLDGtle
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "HotTableView.h"
static NSInteger pushedButton = -MAXFLOAT;

static NSInteger pageNum = 2;


@implementation HotTableView{


    NSMutableArray *_laysArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
        HotTableView *ht = self;
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tongzhi:) name:@"xjwNot2" object:nil];
        
        
        [DataService requestWithUrl:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&page=1&perpage=20&platform=ios&REQUESTCODE=62&swh=480x800&version=3.0.5" httpMethod:@"GET" params:nil fileData:nil success:^(id result) {
            DataService *d = [DataService shareDataService];
            
            d.tag = 1;
            [self requsetSuccess:result];
            [self reloadData];
            
        } failure:^(NSError *error) {
            
            
            
            
        }];
        [self addInfiniteScrollingWithActionHandler:^{
            
            [ht addInfiniteScrollingWithActionHandler];
            
            
            
        }];


    }
    return self;

}

- (void)addInfiniteScrollingWithActionHandler{
    
    NSString *str = [NSString stringWithFormat:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=yes&page=%li&perpage=20&platform=ios&REQUESTCODE=62&swh=480x800&version=3.0.5",pageNum];
    [DataService requestWithUrl:str httpMethod:@"GET" params:nil fileData:nil success:^(id result) {
        DataService *d = [DataService shareDataService];
        d.tag = 2;
        [self requsetSuccess:result];
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];
    



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
    
    
    



}

- (void)requsetSuccess:(id)result{
    DataService *d = [DataService shareDataService];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{

    return _laysArr.count;


}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{

    GTableViewCell *cell =  nil;
    cell =[[[NSBundle mainBundle]loadNibNamed:@"GTableViewCell" owner:self options:nil] lastObject];
    cell.layout = _laysArr[indexPath.row];
    
    
    cell.layout.indexRow = indexPath.row;
            cell.tag = 1;
    
    
    
    return cell;




}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    cellLayout *cellLay =   _laysArr[indexPath.row];
    return   cellLay.cellHeight;



}





@end
