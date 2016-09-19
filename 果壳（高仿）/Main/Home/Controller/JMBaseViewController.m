//
//  JMBaseViewController.m
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import "JMBaseViewController.h"
#import "IIViewDeckController.h"
#import "JMHomeViewController.h"
#import "JMLikeViewController.h"
#import "JMMailViewController.h"
#import "JMSettingViewController.h"

@interface JMBaseViewController ()

@property (strong, nonatomic)UILabel *titleLabel;

@end

@implementation JMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupAllChildVC];

    
    //注册选中左视图cell的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rootViewCloseLeftView:) name:CloseLeftView object:nil];
   
}

#pragma mark -- 导航栏
- (void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置标题栏
    UILabel *label = [[UILabel alloc]init];
    label.text = @"果壳精选";
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = label;
    self.navigationItem.titleView = label;
    self.navigationController.navigationBar.translucent = NO;//去掉导航栏半透明效果
    self.navigationController.navigationBar.barTintColor = MainGreenColor;
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBtnClick) image:@"bar_menu_icon_36x36_" highImage:@"bar_menu_icon_36x36_"];
}


#pragma mark -- 所有子控制器
- (void)setupAllChildVC{
   //添加为自控制器
    JMHomeViewController *homeVC = [[JMHomeViewController alloc]init];
    [self setupChildVC:homeVC];
    [self.view addSubview:homeVC.view];
    
    [self setupChildVC:[[JMLikeViewController alloc] init]];
    
    [self setupChildVC:[[JMSettingViewController alloc] init]];
    
    [self setupChildVC:[[JMMailViewController alloc] init]];
    

}


- (void)setupChildVC:(UIViewController *)childVC{
    [self addChildViewController:childVC];
    childVC.view.frame = self.view.frame;

}



#pragma mark -- 左边栏点击
- (void)leftBtnClick{
   [self.viewDeckController toggleLeftViewAnimated:YES];
}


#pragma mark - rootViewController setup
//通知的方法,根据左视图选中行数切换center的view
//=============================================================================================
- (void)rootViewCloseLeftView:(NSNotification*)noti{
    NSDictionary *dict = noti.object;
    NSInteger row = [[dict objectForKey:@"row"] integerValue];
    
    NSLog(@"%ld",(long)row);
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    switch (row) {
        case JMCControllerHome://0.首页
            [self changeViewWithIndex:JMCControllerHome andTitle:@"果壳精选"];
            break;
            
        case JMCControllerCollection://1.收藏
            [self changeViewWithIndex:JMCControllerCollection andTitle:@"收藏"];
            break;
            
        case JMCControllerSetting://2.设置
            [self changeViewWithIndex:JMCControllerSetting andTitle:@"设置"];
            break;
            
        default ://3.吐槽(建议)
            [self changeViewWithIndex:JMCControllerMail andTitle:@"反馈"];
            break;
    }
    
    //关闭左视图
    [self.viewDeckController closeLeftViewAnimated:YES];
    

}


- (void)changeViewWithIndex:(NSInteger)index andTitle:(NSString *)title{
    [self.view addSubview:self.childViewControllers[index].view];
    self.titleLabel.text = title;
    
   
   
}


- (void)dealloc
{
    //    移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CloseLeftView object:nil];
}




@end
