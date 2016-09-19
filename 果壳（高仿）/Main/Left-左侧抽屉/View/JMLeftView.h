//
//  JMLeftView.h
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftListViewSelectedDelegate <NSObject>

- (void)selectedInLeftViewAtIndexOfRow:(NSInteger)row;


@end

@interface JMLeftView : UIView

@property (assign, nonatomic)id <LeftListViewSelectedDelegate>delegate;
@property(nonatomic,strong)UITableView *leftTableView;

@end
