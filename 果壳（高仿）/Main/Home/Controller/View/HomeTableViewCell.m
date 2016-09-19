//
//  HomeTableViewCell.m
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface HomeTableViewCell ()



@end

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _backView  =[[UIView alloc]init];
        _backView.backgroundColor = [UIColor lightGrayColor];
        _backView.alpha = 0.2;
        [self.contentView addSubview:_backView];
        
        
        //头像
        _headerView = [[UIImageView alloc]init];
        _headerView.backgroundColor = [UIColor clearColor];
        
        _headerView.layer.cornerRadius = 10;
        _headerView.layer.masksToBounds = YES;
        [self.contentView addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.width.offset(20);
            make.height.offset(20);
        }];
        
        
        //姓名
        _author = [[UILabel alloc]init];
        _author.textColor = [UIColor lightGrayColor];
        _author.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_author];
        [_author mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerView.mas_right).offset(5);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.width.offset(100);
            make.height.offset(20);
            
        }];
        //线
        _line  =[[UILabel alloc]init];
        _line.backgroundColor = [UIColor lightGrayColor];
        _line.alpha = 0.5;
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(0);
            make.top.mas_equalTo(self.contentView.mas_top).offset(40);
            make.width.mas_equalTo(self.contentView);
            make.height.mas_offset(1);
        }];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 1;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).offset(60);
            make.width.mas_equalTo(kSCREEN_WIDTH-30-35-75);
        }];
        
        _summaryLabel = [[UILabel alloc]init];
        _summaryLabel.numberOfLines = 2;
        _summaryLabel.textColor = [UIColor lightGrayColor];
        _summaryLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_summaryLabel];
        [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(kSCREEN_WIDTH-30-35-75);
        }];
        
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(60);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.mas_equalTo(85);
            make.height.mas_equalTo(60);
        }];
        
        
        
    }
    return self;
}


-(void)setupModel:(HomeModel *)model{
    _model = model;
    _contentLabel.text = model.title;
    [_imgView setImageWithURL:[NSURL URLWithString:_model.headline_img_tb]];

}




@end
