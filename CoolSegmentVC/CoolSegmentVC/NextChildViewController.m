//
//  NextChildViewController.m
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "NextChildViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface NextChildViewController ()

@property (nonatomic, copy) NSMutableArray *customTabbarArray;

@end

@implementation NextChildViewController


#pragma mark - life style

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)configData
{
    NSDictionary *theStepOne = @{
                               @"title" : @"step1",
                               @"image" : @"cool_step_1",
                               @"disabledImage" : @"cool_step_3",
                               @"selectImage" : @"cool_step_2",
                               @"controller" : @"OneViewController",
                               @"nextAction" : @"oneAction",
                               };
    NSDictionary *theStepTwo = @{
                                 @"title" : @"step2",
                                 @"image" : @"cool_step_1",
                                 @"disabledImage" : @"cool_step_3",
                                 @"selectImage" : @"cool_step_2",
                                 @"controller" : @"TwoViewController",
                                 @"nextAction" : @"TwoAction",
                                 };
    NSDictionary *theStepThree = @{
                                 @"title" : @"step3",
                                 @"image" : @"cool_step_1",
                                 @"disabledImage" : @"cool_step_3",
                                 @"selectImage" : @"cool_step_2",
                                 @"controller" : @"ThreeViewController",
                                 @"nextAction" : @"ThreeAction",
                                 };
    
    
    _customTabbarArray = [@[theStepOne, theStepTwo, theStepThree] mutableCopy];

    for (NSUInteger i = 0;  i < _customTabbarArray.count; i ++) {
        NSDictionary *dic = _customTabbarArray[i];
        id controller = [[NSClassFromString(dic[@"controller"]) alloc] init];
        if ([controller respondsToSelector:@selector(setGoToAction:)]) {
            [controller setGoToAction:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:NSSelectorFromString(dic[@"nextAction"])];
#pragma clang diagnostic pop
            }];
        }
        [self.contentControllers addObject:controller];
    }
    
    [self createSegmentBar:_customTabbarArray tip:@"这里是小tip"];
}


#pragma mark - action method

- (void)oneAction
{
    [self segmentBarClick:1];
}

- (void)TwoAction
{
    [self segmentBarClick:2];
}

- (void)ThreeAction
{
    NSLog(@"最后一步提交信息喽");
}

@end
