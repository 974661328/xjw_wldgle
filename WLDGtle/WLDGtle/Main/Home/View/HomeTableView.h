//
//  HomeTableView.h
//  WLDGtle
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 Epping Lu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeTableView : UITableView<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic,weak)UIPageControl * pageControl;

@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic ,strong)UIScrollView *scrollView;

@end
