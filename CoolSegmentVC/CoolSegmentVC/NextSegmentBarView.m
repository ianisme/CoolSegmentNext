//
//  NextSegmentBarView.m
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "NextSegmentBarView.h"
#import "NextSegmentButton.h"

#define NextBtnItem_TAG 1245

@interface NextSegmentBarView()

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic) NSUInteger oldIndex;

@end

@implementation NextSegmentBarView


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        _items = items;
        _oldIndex = 0;
        [self creatView];
    }
    return self;
}


#pragma mark - private method

- (void)creatView
{
    UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:contentView];
    _contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnWidth = contentView.bounds.size.width/(_items.count + 1);
    
    for (NSUInteger i = 0; i < _items.count - 1; i ++) {
        UIView *lineView = [[UIView alloc] init];
        [contentView addSubview:lineView];
        lineView.backgroundColor = [UIColor greenColor];
        lineView.frame = CGRectMake(0, 0, btnWidth - 20, 0.5f);
        CGPoint lineViewCenter = lineView.center;
        lineViewCenter.y = contentView.center.y - 10;
        lineViewCenter.x = btnWidth * 0.5f + (i+1) * btnWidth;
        lineView.center = lineViewCenter;
    }
    
    
    for (NSUInteger i = 0; i < _items.count; i ++) {
        NSDictionary *dic = _items[i];
        
        NextSegmentButton *btn = [[NextSegmentButton alloc] initWithFrame:CGRectMake(btnWidth * 0.5f + i * btnWidth, self.bounds.size.height/2.0f - 40/2.0f, btnWidth, 40)];
//        btn.backgroundColor = [UIColor blueColor];
        [btn setClipsToBounds:YES];
        [contentView addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = NextBtnItem_TAG + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [btn setTitle:dic[@"title"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:dic[@"selectImage"]] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:dic[@"disabledImage"]] forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
}

- (void)refreshButton:(NSUInteger)index
{
    for (UIView *subView in _contentView.subviews) {
        if ([subView isKindOfClass:[NextSegmentButton class]]) {
            NextSegmentButton *btn = (NextSegmentButton *)subView;
            if (btn.tag - NextBtnItem_TAG == index) {
                btn.selected = YES;
            }else{
                btn.selected = NO;
            }
            if (btn.tag - NextBtnItem_TAG > _oldIndex || index == 0) {
                btn.enabled = YES;
            } else {
                btn.enabled = NO;
            }
        }
    }
    _oldIndex = index;
}


#pragma mark - action method

- (void)btnClick:(id)sender
{
    NSUInteger index = ((NextSegmentButton *)sender).tag - NextBtnItem_TAG;
    if (index - _oldIndex != 1 && index != 0) {
        return;
    }
    
    if (self.segmentBarBtnAction) {
        self.segmentBarBtnAction(index);
    }
}

@end
