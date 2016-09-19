//
//  JMBaseViewController.h
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    JMCControllerHome, // 首页
    JMCControllerCollection, // 收藏
    JMCControllerSetting, // 设置
    JMCControllerMail, // 吐槽
} JMControllerType;

@interface JMBaseViewController : UIViewController

@end
