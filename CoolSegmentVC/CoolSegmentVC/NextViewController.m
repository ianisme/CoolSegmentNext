//
//  NextViewController.m
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "NextViewController.h"
#import "NextCollectionViewCell.h"
#import "NextFlowLayout.h"
#import "NextSegmentBarView.h"

static NSString * const ReuseIdentifier = @"ReuseIdentifier";

@interface NextViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NextSegmentBarView *segmentBarView;

@property (nonatomic, strong) UICollectionView *contentScrollView;

@property (nonatomic, assign) BOOL isInitial;

@end

@implementation NextViewController


#pragma mark - life sytle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSource];
    [self configContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        
        _isInitial = YES;
        NSUInteger count = self.contentControllers.count;
        _contentScrollView.contentSize = CGSizeMake(count * self.contentScrollView.bounds.size.width, 0);
        [_contentScrollView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    }
}

- (void)viewDidLayoutSubviews
{
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_contentScrollView reloadData];
    });
}


#pragma mark - interface method

- (void)createSegmentBar:(NSArray *)items tip:(NSString *)tip;
{
    CGFloat tipViewHeight = 0;
    if (tip.length > 0) {
        tipViewHeight = 32.0f;
        UILabel *tipLabel = [[UILabel alloc] init];
        [self.view addSubview:tipLabel];
        tipLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, tipViewHeight);
        tipLabel.text = tip;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    
    self.contentScrollView.frame = CGRectMake(0, 82 + tipViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - 82 - tipViewHeight);
    
    NextSegmentBarView *segmentBarView = [[NextSegmentBarView alloc] initWithFrame:CGRectMake(0, tipViewHeight, self.view.bounds.size.width, 82) items:items];
    [self.view addSubview:segmentBarView];
    _segmentBarView = segmentBarView;
    
    __weak typeof(self) weakSelf = self;
    _segmentBarView.segmentBarBtnAction = ^(NSUInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf segmentBarClick:index];
    };
    
    [_segmentBarView refreshButton:0];
}

#pragma mark - private method

- (void)initSource
{
    _contentControllers = [@[] mutableCopy];
}

- (void)configContentView
{
    NextFlowLayout *layout = [[NextFlowLayout alloc] init];
    _contentScrollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0) collectionViewLayout:layout];
    _contentScrollView.backgroundColor = self.view.backgroundColor;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.scrollEnabled = NO;
    _contentScrollView.bounces = NO;
    _contentScrollView.delegate = self;
    _contentScrollView.dataSource = self;
    [self.view addSubview:_contentScrollView];
}

- (void)segmentBarClick:(NSUInteger)index
{
    [self.segmentBarView refreshButton:index];
    CGFloat offsetX = index * self.contentScrollView.bounds.size.width;
    [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - UICollectionView datasource and delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    UIViewController *vc = self.contentControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, collectionView.frame.size.width, collectionView.frame.size.height);
    cell.contentViewController = vc;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NextCollectionViewCell *nextCell = (NextCollectionViewCell *)cell;
    [nextCell addViewControllerToParentViewController:self];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NextCollectionViewCell *nextCell = (NextCollectionViewCell *)cell;
    [nextCell removeViewControllerFromParentViewController];
}

@end
