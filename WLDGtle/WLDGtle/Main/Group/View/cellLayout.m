//
//  cellLayout.m
//  WLDGtle
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "cellLayout.h"
#import "WXLabel.h"
#import "Common.h"


#define kSpace 10

#define kCellHeight 80

#define kButtonHeight 30
//图片空息
#define kImageGap 5



@implementation cellLayout
- (NSMutableArray *)imageFrameArr{
    if (_imageFrameArr ==nil) {
        _imageFrameArr = [NSMutableArray array];
    }
    return _imageFrameArr;

}
- (void)setGmodel:(DgtleModel *)gmodel{
    
    _gmodel = gmodel;
    
    self.cellHeight = kCellHeight;
CGFloat   subTextHeight = [WXLabel getTextHeight:16 width:kScreenWidth - 2 *kSpace text:gmodel.subject];
    
    self.subTextFrame = CGRectMake(kSpace, kCellHeight + kSpace, kScreenWidth - 2 *kSpace, subTextHeight);

    self.cellHeight =  CGRectGetMaxY(self.subTextFrame);
   // NSLog(@"%f",self.cellHeight);
    CGFloat messageHeight = [WXLabel getTextHeight:10 width:kScreenWidth- 2*kSpace text:gmodel.message];
    
    
   


    if (_isClick == NO) {
        
        if (messageHeight > 60) {
            
            messageHeight = 60;
            
            self.buttonFrame = CGRectMake(kSpace, _cellHeight + messageHeight , 100, 20);
            
            
            _cellHeight = CGRectGetMaxY(self.buttonFrame)+kSpace;
            
        }else{
        
            _cellHeight = _cellHeight + messageHeight+kSpace;
        
        }
            self.messageTextFrame = CGRectMake(kSpace, CGRectGetMaxY(self.subTextFrame) , kScreenWidth - 2 * kSpace, messageHeight);

    }else{
        
    
        _cellHeight = _cellHeight +messageHeight +kSpace;
        
        self.messageTextFrame = CGRectMake(kSpace, CGRectGetMaxY(self.subTextFrame) , kScreenWidth - 2 * kSpace, messageHeight);

        
    }
    
    //九宫格

//    
//     CGFloat imgX = CGRectGetMinX(self.messageTextFrame);
//     CGFloat imgY = CGRectGetMaxY(self.messageTextFrame);
    CGFloat imgX = kSpace;
    CGFloat imgY = _cellHeight;
     CGFloat immSize = (CGRectGetWidth(self.messageTextFrame) - 2 *kImageGap) / 3;
     

     NSInteger row = 0;

     NSInteger column = 0;
    
    

     for (NSInteger i = 0; i <self.gmodel.attachlist.count; i++) {
     

     row  = i / 3;
     column = i % 3;
     
     
     CGRect rect = CGRectMake(imgX + column *(immSize + kImageGap), imgY + row *(immSize +kImageGap), immSize, immSize);
     
     [self.imageFrameArr addObject:[NSValue valueWithCGRect:rect]];
         
     
     }
     
          NSInteger line = (self.imageFrameArr.count + 2) / 3;
     
     self.cellHeight += line * immSize + MAX(0, line - 1) *kImageGap + kSpace;
    
    
    //加剩余frame
    for (NSInteger i =self.imageFrameArr.count; i < 9; i++) {
        
        //添加剩余的frame值
        [self.imageFrameArr addObject:[NSValue valueWithCGRect:CGRectZero]];
    }
    
    
    
    
//    _cellHeight = CGRectGetMaxY(self.buttonFrame)+kSpace;
//    
//    if
//        (_isClick ) {
//        
//            _cellHeight = CGRectGetMaxY(self.messageTextFrame)+kSpace;
//    }
    
    
}
//- (void)getPictureArray{
//    
//    for (<#type *object#> in <#collection#>) {
//        <#statements#>
//    }
//
//
//
//}

//- (void)buttonAction:(UIButton)*but{
//
//
//
//}

@end
