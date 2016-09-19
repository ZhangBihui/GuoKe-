//
//  HomeTableViewCell.h
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic,strong) HomeModel *model;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *summaryLabel;
@property (strong, nonatomic)UILabel *line;
@property (strong, nonatomic)UIView *backView;
@property (strong, nonatomic)UIImageView *headerView;
@property (strong, nonatomic)UILabel *author;


@end
