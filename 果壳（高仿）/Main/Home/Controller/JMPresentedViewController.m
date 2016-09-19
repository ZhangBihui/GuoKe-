//
//  JMPresentedViewController.m
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/18.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import "JMPresentedViewController.h"
#import "IIViewDeckController.h"

@interface JMPresentedViewController ()

@end

@implementation JMPresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.textTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"bar_dismiss_icon_21x21_"] forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 21, 21);
    [leftButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:item];
    self.navigationItem.titleView = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_link]];
    [webview loadRequest:request];
    
    
   
}


- (void)dismissSelf {
    
    self.presentingViewController.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
    [UIView animateWithDuration:0.5 animations:^{
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    IIViewDeckController *deckController = (IIViewDeckController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    //不让MMDrawerController滑动
    [deckController setPanningMode:IIViewDeckNoPanning];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    IIViewDeckController *deckController = (IIViewDeckController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    //打开MMDrawerController的滑动
    [deckController setPanningMode:IIViewDeckAllViewsPanning];
    
    
}


@end
