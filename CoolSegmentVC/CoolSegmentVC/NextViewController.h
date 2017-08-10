//
//  NextViewController.h
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *contentControllers;

- (void)createSegmentBar:(NSArray *)items tip:(NSString *)tip;

- (void)segmentBarClick:(NSUInteger)index;

@end
