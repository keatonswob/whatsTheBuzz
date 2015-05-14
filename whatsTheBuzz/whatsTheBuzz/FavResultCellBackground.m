//
//  FavResultCellBackground.m
//  whatsTheBuzz
//
//  Created by Keaton Swoboda on 5/13/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FavResultCellBackground.h"

@implementation FavResultCellBackground

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *lightGradientColor = [UIColor colorWithRed:1 green:1 blue:1.0 alpha:1.0];
    UIColor *darkGradientColor = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0];
    
    CGFloat locations[2] = {0.0, 1.0};
    CFArrayRef colors = (__bridge CFArrayRef) [NSArray arrayWithObjects:(id)lightGradientColor.CGColor,
                                               (id)darkGradientColor.CGColor,
                                               nil];
    
    CGColorSpaceRef colorSpc = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpc, colors, locations);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.5, 0.0), CGPointMake(0.5, 100.0), kCGGradientDrawsAfterEndLocation); //Adjust second point according to your view height
    
    CGColorSpaceRelease(colorSpc);
    CGGradientRelease(gradient);
}

@end
