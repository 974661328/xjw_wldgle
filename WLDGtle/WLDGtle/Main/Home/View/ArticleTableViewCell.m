//
//  ArticleTableViewCell.m
//  WLDGtle
//
//  Created by Epping Lu on 16/8/15.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+TimeAgo.h"


@implementation ArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _authorImage.layer.cornerRadius = 20;
//    _authorImage.layer.
    [_authorImage.layer setMasksToBounds: YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHomeModel:(HomeModel *)homeModel{
    
    
    _homeModel = homeModel;
    NSInteger a = homeModel.authorid.integerValue;
    
    NSInteger frist = a/10000;
    NSInteger sec = a%10000/100;
    NSInteger third = a%10000%100;
    NSString *str = [NSString stringWithFormat:@"%02li/%02li/%02li",frist,sec,third];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.dgtle.com/uc_server/./data/avatar/000/%@_avatar_middle.jpg",str]];
    [_authorImage sd_setImageWithURL:url];
//    _timeLabel.text = homeModel.dateline.stringValue;
    _timeLabel.text = [self pasrseDate:homeModel.dateline.stringValue];
    
    
    
    
    _author.text = homeModel.author;
    
    
    [_bodyImage sd_setImageWithURL:[NSURL URLWithString:homeModel.pic_url]];

    _titleLabel.text = homeModel.title;
    _summary.text = homeModel.summary;
    
    



}


- (NSString *)pasrseDate:(NSString *)time{
    
    NSTimeInterval timeinterval = [time doubleValue]+28800;
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeinterval];
    
    return [detailDate timeAgo];
    
}







@end
