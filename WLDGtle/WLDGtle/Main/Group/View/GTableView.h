//
//  GTableView.h
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//


#import <UIKit/UIKit.h>
@class DgtleModel;
@interface GTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic, retain)DgtleModel *Gmodel;

@property(nonatomic, retain)NSMutableArray *layoutArr;
@end
