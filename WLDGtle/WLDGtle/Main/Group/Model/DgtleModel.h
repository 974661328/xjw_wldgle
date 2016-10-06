//
//  DgtleModel.h
//  WLDGtle
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DgtleModel : NSObject
// 标题
@property (nonatomic, copy)NSString *forum_name;
//作者id 提供头像
@property (nonatomic, copy)NSNumber *authorid;
//粗字
@property (nonatomic, copy)NSString *subject;
//正文
@property (nonatomic, copy)NSString *message;
//点赞
@property (nonatomic,copy)NSString *recommend_add;
//回复数
@property(nonatomic,copy)NSNumber *replies;
//日期

@property (nonatomic,copy)NSNumber *dateline;
//图片
@property (nonatomic, copy)NSDictionary *attachlist;
//作者
@property (nonatomic,copy)NSString *author;
@end
