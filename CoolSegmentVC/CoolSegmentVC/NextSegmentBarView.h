//
//  NextSegmentBarView.h
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextSegmentBarView : UIView

@property (nonatomic, copy) void(^segmentBarBtnAction)(NSUInteger);

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)refreshButton:(NSUInteger)index;

@end
