//
//  NextCollectionViewCell.m
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "NextCollectionViewCell.h"

@implementation NextCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addViewControllerToParentViewController:(UIViewController *)parentViewController
{
    [parentViewController addChildViewController:self.contentViewController];
    [self.contentViewController didMoveToParentViewController:parentViewController];
    [self.contentView addSubview:self.contentViewController.view];
}

- (void)removeViewControllerFromParentViewController
{
    [self.contentViewController.view removeFromSuperview];
    [self.contentViewController willMoveToParentViewController:nil];
    [self.contentViewController removeFromParentViewController];
}

@end
