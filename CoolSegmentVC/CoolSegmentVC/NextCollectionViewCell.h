//
//  NextCollectionViewCell.h
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIViewController *contentViewController;

- (void)addViewControllerToParentViewController:(UIViewController *)parentViewController;

- (void)removeViewControllerFromParentViewController;

@end
