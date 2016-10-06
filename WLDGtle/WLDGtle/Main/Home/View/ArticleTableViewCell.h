//
//  ArticleTableViewCell.h
//  WLDGtle
//
//  Created by Epping Lu on 16/8/15.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface ArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bodyImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (nonatomic, strong)HomeModel *homeModel;

@end
