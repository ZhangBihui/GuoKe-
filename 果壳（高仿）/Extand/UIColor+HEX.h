//
//  UIColor+HEX.h
//  Created by mac on 15/12/14.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha;
- (NSString *)HEXString;

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

+ (UIColor *)colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;

- (CGFloat)getRed;
- (CGFloat)getGreen;
- (CGFloat)getBlue;

+ (UIColor *)colorRatio:(CGFloat)ratio fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

@end
