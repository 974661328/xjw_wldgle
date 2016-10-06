//
//  cellLayout.h
//  WLDGtle
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DgtleModel.h"
@interface cellLayout : NSObject

@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGRect subTextFrame;
@property(nonatomic,assign)CGRect messageTextFrame;

@property(nonatomic,strong)DgtleModel *gmodel;
@property(nonatomic,assign)CGRect buttonFrame;

//第几个
@property(nonatomic, assign)NSInteger indexRow;
//按钮是否点击
@property(nonatomic, assign)BOOL isClick;
@property(nonatomic, copy)NSMutableArray *imageFrameArr;
@end
