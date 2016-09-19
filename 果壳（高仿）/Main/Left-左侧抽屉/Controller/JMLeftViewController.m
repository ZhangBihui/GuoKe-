//
//  JMLeftViewController.m
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import "JMLeftViewController.h"
#import "JMLeftView.h"
#import "IIViewDeckController.h"
#import "JMHomeViewController.h"

@interface JMLeftViewController ()<LeftListViewSelectedDelegate>

/**
 *  上次选中的行
 */
@property (nonatomic, assign) NSInteger preSelectedRow;
@property (nonatomic, strong) JMLeftView *leftView;


@end

@implementation JMLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MaindarkColor;
    //默认选中第0行
    self.preSelectedRow = 0;
    
    JMLeftView *leftView = [[JMLeftView alloc]initWithFrame:self.view.bounds];
    leftView.delegate = self;
    [self.view addSubview:leftView];
    self.leftView = leftView;


}


- (void)selectedInLeftViewAtIndexOfRow:(NSInteger)row{
    if (self.preSelectedRow == row) {//同行，关闭
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }else{
        self.preSelectedRow = row;
        NSDictionary *dict = @{@"row":[NSString stringWithFormat:@"%ld",(long)row]};
        [[NSNotificationCenter defaultCenter] postNotificationName:CloseLeftView object:dict];
    
    
    }


}



@end
