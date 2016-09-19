//
//  UIBarButtonItem+Extension.h
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
