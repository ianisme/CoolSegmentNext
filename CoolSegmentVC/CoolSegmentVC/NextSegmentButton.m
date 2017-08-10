//
//  NextSegmentButton.m
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "NextSegmentButton.h"

@implementation NextSegmentButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2 + 3;
    self.imageView.center = center;
    
    // Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 7;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
