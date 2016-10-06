//
//  GTableViewCell.h
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DgtleModel.h"
#import "WXLabel.h"
#import "cellLayout.h"
#import "WXPhotoBrowser.h"
@class DgtleModel;
//@protocol xjw <NSObject>
//
//- (void)protocalXjw:(NSInteger)a;
//
//@end
typedef void(^XJWBlock)(NSInteger);
@interface GTableViewCell : UITableViewCell<WXLabelDelegate,PhotoBrowerDelegate>
//@property(nonatomic, strong)DgtleModel *gmodel;
@property(nonatomic, strong)cellLayout *layout;
@property(nonatomic,assign)NSInteger tag;
//@property(nonatomic, assign)id<xjw> delegate;
//@property(nonatomic, copy)XJWBlock myBlock;
@end
