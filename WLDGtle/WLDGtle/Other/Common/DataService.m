//
//  DataService.m
//  WX93WeiBo
//
//  Created by zhangzh on 16/8/12.
//  Copyright © 2016年 wxhl. All rights reserved.
//

#import "DataService.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

//#define BaseUrl @"https://api.weibo.com/2/"
@implementation DataService

static DataService *instance = nil;


+ (instancetype)requestWithUrl:(NSString *)url httpMethod:(NSString *)method params:(NSDictionary *)params fileData:(NSDictionary *)fileDic success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;{
    
    //1.拼接完整的接口
    
//    url = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
//    
//    //2.设置参数
//     NSMutableDictionary *mDic= [NSMutableDictionary dictionaryWithDictionary:params];
//    
//     AppDelegate *appDelegate= [UIApplication sharedApplication].delegate;
//    
//    [mDic setObject:appDelegate.sinaweibo.accessToken forKey:@"access_token"];
    
    
    //发送网络请求
     DataService *dataS =  [self shareDataService];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //判断请求方式
    if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        
        [manager GET:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            sBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            fBlock(error);
        }];
        
        
        
    }else if ([method caseInsensitiveCompare:@"POST"]==NSOrderedSame){
        
        
        //如果发送带图片的微博
        if (fileDic) {
            
            
            [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                //拼接上传到服务器的数据(图片数据)
                
                for (NSString *key in fileDic) {
                    
                    [formData appendPartWithFileData:fileDic[key] name:key fileName:key mimeType:@"image/jpeg"];
                    
                }
                
                
                
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                sBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                fBlock(error);
            }];
        }
        
        
        
        
        //发送文字的微博
        [manager POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            sBlock(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            fBlock(error);
        }];
        
        
        
        
    }
    
    
    return dataS;
    
    
    
    
    
    
}
+(instancetype)shareDataService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      instance = [[super allocWithZone:nil] init];
    });

    return instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{

    return [self shareDataService];


}
@end
