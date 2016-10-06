//
//  GTableView.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "GTableView.h"
#import "AFNetworking.h"
#import "GTableViewCell.h"
#import "YYModel.h"
#import "DgtleModel.h"
#import "cellLayout.h"
#import "DataService.h"


@implementation GTableView{

//    NSMutableArray *_layoutArr;


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self = [super initWithFrame:frame style:style];
    if (self) {
        self.layoutArr = [NSMutableArray array];

        self.delegate = self;
        self.dataSource = self;
        self.editing = NO;
//        [self _requestData];
        
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{

    return _layoutArr.count;

}              // Default is 1 if not implemented


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 10;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{


    return 0.001;
}
- (void)_requestData{

//    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
//    
//    
//    _layoutArr = [NSMutableArray array];
    
    
//    [manage GET:@"http://www.dgtle.com/api/dgtle_api/v1/api.php?apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&digest=1&inapi=yes&page=1&perpage=10&platform=ios&REQUESTCODE=46&swh=480x800&version=3.0.5" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        //            NSLog(@"%@",responseObject);
//        
//        NSDictionary *dic = responseObject;
//        //  NSLog(@"%@",dic);
//        NSArray *arr = dic[@"newlist"];
//        
//        NSInteger i = 0;
//        
//        for (NSDictionary *model in arr) {
//           
//            cellLayout *layout = [[cellLayout alloc]init];
//
//            
//            if (i == pushedButton) {
//                
//                layout.isClick = YES;
//                
//           
//                
//            }
//            layout.gmodel = [DgtleModel yy_modelWithDictionary:model];
//            [_layoutArr addObject:layout];
//            
//            i++;
//            
//            
//        }
////        for (cellLayout *l in _layoutArr) {
////           // NSLog(@"++%i",l.isClick);
////        }
//        
//        
//        // NSLog(@"------------------------%li",(unsigned long)_dataArr.count);
//        [self reloadData];
//    } failure:nil];
//    
    
    


}








- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;



}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (_dataArr == nil) {
//        return nil;
//    }
    GTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cid"];
    if (cell == nil) {
        cell.tag = 0;
        cell =[[[NSBundle mainBundle]loadNibNamed:@"GTableViewCell" owner:self options:nil] lastObject];
     //   NSLog(@"======%@",cell);
        
    }
    
//   cell.layout.indexRow = indexPath.row;
//    NSLog(@"----------%li",cell.layout.indexRow);
    cell.layout = _layoutArr[indexPath.section];

    cellLayout *layout = cell.layout;
    
    layout.indexRow = indexPath.section;
    
//    NSLog(@"----%li",layout.indexRow);
//    cell.myBlock = ^(NSInteger a){
//        
//        
//        pushedButton = a;
//        [self _requestData];
//        
//        
//        
//    
//    
//    };
   
   // cell.gmodel = [DgtleModel yy_modelWithDictionary:_dataArr[indexPath.row]];
    
    return cell;
    
    



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    cellLayout *layout = _layoutArr[indexPath.section];
    
    return layout.cellHeight;

}





@end
