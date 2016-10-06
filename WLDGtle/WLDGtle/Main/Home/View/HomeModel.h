//
//  HomeModel.h
//  WLDGtle
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property(nonatomic, copy)NSString *pic_url;
@property(nonatomic, copy)NSNumber *dateline;
@property(nonatomic, copy)NSString *author;
//大字
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSNumber *authorid;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic, copy)NSString *fromurl;


@end
