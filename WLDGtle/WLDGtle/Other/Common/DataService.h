//
//  DataService.h
//  WX93WeiBo
//
//  Created by zhangzh on 16/8/12.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id result);
typedef void (^FailureBlock)(NSError *error);

@interface DataService : NSObject
//网络请求的方法
+ (instancetype)shareDataService;
+ (instancetype)requestWithUrl:(NSString *)url httpMethod:(NSString *)method params:(NSDictionary *)params fileData:(NSDictionary *)fileDic success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;

@property (nonatomic, assign)NSInteger tag;
@end
