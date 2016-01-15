//
//  EllipseRectView.m
//  Shopping
//
//  Created by qianfeng on 16/1/14.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "EllipseRectView.h"

@implementation EllipseRectView
- (void)drawRect:(CGRect)rect {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ref, 11, 11, 10, 20 / 180.0 * M_PI, -325 / 180.0 * M_PI, 1);
    CGContextSetLineWidth(ref, 1);
    [[UIColor grayColor] set];
    
    
    CGContextMoveToPoint(ref, 6, 6);
    CGContextAddLineToPoint(ref, 16, 16);
    
    CGContextMoveToPoint(ref, 16, 6);
    CGContextAddLineToPoint(ref, 6, 16);
    CGContextStrokePath(ref);
    
}

@end
