//
//  GTableViewCell.m
//  WLDGtle
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//
/*
 
 // 标题
 @property (nonatomic, copy)NSString *forum_name;
 //粗字
 
 @property (nonatomic, copy)NSString *subject;
 //正文
 @property (nonatomic, copy)NSString *message;
 //点赞
 @property (nonatomic,copy)NSString *recommend_add;
 //回复数
 @property(nonatomic,copy)NSString *replies;
 //日期
 
 @property (nonatomic,copy)NSString *dateline;
 //图片
 @property (nonatomic, copy)NSDictionary *picDic;
 
 */

#import "GTableViewCell.h"

#import "Common.h"
#import "UIImageView+WebCache.h"
#import "NSDate+TimeAgo.h"




@implementation GTableViewCell{
//    
//    CGRect _subText;
//    CGRect _messageText;
//    
//    CGFloat _cellHeight;
    WXLabel *_subText;
    WXLabel *_messageText;
    UIButton *_appendBut;
    NSMutableArray *_cellImageArr;
    
    
    __weak IBOutlet UILabel *_form_name;


    __weak IBOutlet UILabel *_timeLAble;
    __weak IBOutlet UILabel *_author;


    
    __weak IBOutlet UIImageView *_authorImage;

}

- (UILabel *)subText{
    
    
    if (_subText == nil) {
        _subText = [[WXLabel alloc]initWithFrame:CGRectZero];
        _subText.font = [UIFont systemFontOfSize:20];
        _subText.wxLabelDelegate = self;
        [self.contentView addSubview:_subText];
    }
    
    return _subText;

}
- (NSMutableArray *)cellImageArr{
    if (_cellImageArr == nil) {

        _cellImageArr= [NSMutableArray array];
        
        for (NSInteger i = 0; i < 9; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //100
            
            //图片拉伸变形了
            //            UIViewContentModeScaleToFill 拉伸填充(会变形)
            // UIViewContentModeScaleAspectFit 按比例缩放
            //UIViewContentModeScaleAspectFill 按原图显示
            
            // 会超出 imageView的范围
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            imageView.tag = i;

            imageView.clipsToBounds = YES;

            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            
            
            
            [imageView addGestureRecognizer:tap];
            [self.contentView addSubview:imageView];
            [_cellImageArr addObject:imageView];
        }
        
        
        
    }
    
    return _cellImageArr;


}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [WXPhotoBrowser showImageInView:self.window selectImageIndex:tap.view.tag delegate:self];

    


}


- (UILabel *)messageText{
    
    if (_messageText == nil) {
        _messageText = [[WXLabel alloc]initWithFrame:CGRectZero];
        _messageText.font = [UIFont systemFontOfSize:13];
        _messageText.wxLabelDelegate = self;
      [self.contentView addSubview:_messageText];
    }
    
    return _messageText;
    
}

- (UIButton *)appendBut{
   
    if (_appendBut == nil) {
        _appendBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _appendBut.frame = CGRectZero;
        [_appendBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_appendBut];
    }
    return _appendBut;


}


-(void)setLayout:(cellLayout *)layout{

    _layout = layout;
    

    self.appendBut.frame = _layout.buttonFrame;
 //   NSLog(@"++++%f",self.appendBut.frame.size.height);
    [_appendBut setTitle:@"查看全文" forState:UIControlStateNormal];
   _appendBut.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [_appendBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    

    self.subText.frame = _layout.subTextFrame;
    self.messageText.frame = _layout.messageTextFrame;
    
 //   NSLog(@"%@",_layout.gmodel.subject);
    
    self.subText.text = _layout.gmodel.subject;
   // self.subText.backgroundColor = [UIColor redColor];
    
    self.messageText.text = _layout.gmodel.message;
    
    //self.messageText.backgroundColor = [UIColor greenColor];
    
    _form_name.text = _layout.gmodel.forum_name;
    
    _author.text = _layout.gmodel.author;
    
    _timeLAble.text = [self pasrseDate:_layout.gmodel.dateline.stringValue];
    
    
    
    NSString *str = [self sepNumer];
    
    
    
    //加载用户头像
    NSString *appstr = [NSString stringWithFormat:@"http://www.dgtle.com/uc_server/./data/avatar/000/%@_avatar_middle.jpg",str];
    
    
    [_authorImage sd_setImageWithURL:[NSURL URLWithString:appstr]];
    
    
//    显示多张图片frame
    for (NSInteger i = 0; i < 9; i++) {
        UIImageView *imageView= self.cellImageArr[i];
        
        imageView.frame = [_layout.imageFrameArr[i] CGRectValue];
       // NSLog(@"count :%lu",(unsigned long)_layout.imageFrameArr.count);
        
       // NSLog(@"frame%f",imageView.frame.size.height);
        
    }
    
   
    
    NSDictionary *dicAttach = self.layout.gmodel.attachlist;
    
    if (dicAttach != nil ) {
            [self showImgWithurls:[dicAttach allValues]];
    }
    
    
    
    
}
- (void)showImgWithurls:(NSArray *)urls{
    
    
    for (NSInteger i = 0; i < urls.count; i++) {
        
        UIImageView *imageView= [self.cellImageArr objectAtIndex:i];
       // [imageView sd_setImageWithURL:urls[i][@"thumbnail_pic"]];
        [imageView sd_setImageWithURL:urls[i]];
    
    }
    
    
    
    
    
}

//分割数字 ../../..

- (NSString *)sepNumer{
   
    NSInteger a = _layout.gmodel.authorid.integerValue;

    NSInteger frist = a/10000;
    NSInteger sec = a%10000/100;
    NSInteger third = a%10000%100;
    NSString *str = [NSString stringWithFormat:@"%02li/%02li/%02li",frist,sec,third];
    
    return str;
    
    



}


- (void)buttonAction:(UIButton *)but{
    
   // NSLog(@"点击");
    //NSLog(@"%li",self.layout.indexRow);
   // self.myBlock(self.layout.indexRow);
//    NSLog(@"dianji;");
    
//    [_delegate protocalXjw:self.layout.indexRow];
    if (self.tag == 0) {
        
        NSDictionary *dic =@{
                             
                             @"row":@(self.layout.indexRow)
                             
                             };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"xjwNot" object:self userInfo:dic];
        
    }if (self.tag ==1) {
        NSDictionary *dic =@{
                             
                             @"row":@(self.layout.indexRow)
                             
                             };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"xjwNot2" object:self userInfo:dic];
    }
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    NSLog(@"%@", view);
//    return view;
//}

- (void)awakeFromNib {
    _authorImage.layer.cornerRadius = 20;
    _authorImage.layer.borderColor = [UIColor grayColor].CGColor;
    _authorImage.layer.borderWidth = 0.5;
    _authorImage.layer.masksToBounds = YES;
    
  //  self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.userInteractionEnabled = NO;
 // self.contentView.userInteractionEnabled = YES;
    
    
    // Initialization code
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(10, 10, 10, 10);
//    button.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:button];
//    
//    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//photo delegate
#pragma mark ------photodelegate-------
- (NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser;{
    
    return _layout.gmodel.attachlist.count;

}

//返回需要显示的图片对应的Photo实例,通过Photo类指定大图的URL,以及原始的图片视图
- (WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;{

    WXPhoto *photo = [[WXPhoto alloc]init];
    NSArray *urls = nil;
    
    photo.srcImageView = self.cellImageArr[index];
//    if (_layout.gmodel.) {
//        <#statements#>
//    }
//    NSString *str =
    NSDictionary *dic = _layout.gmodel.attachlist;
    if (dic.count > 0) {
        urls = [dic allValues];
    }
    NSString *str = urls[index];
    photo.url = [NSURL URLWithString:str];
    return photo;
}

//转换时间戳
- (NSString *)pasrseDate:(NSString *)time{

    NSTimeInterval timeinterval = [time doubleValue]+28800;
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeinterval];
    
        return [detailDate timeAgo];
    
}






@end
