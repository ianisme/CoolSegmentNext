//
//  NextFlowLayout.m
//  CoolSegmentVC
//
//  Created by ian on 2017/7/19.
//  Copyright © 2017年 RengFou.Inc. All rights reserved.
//

#import "NextFlowLayout.h"

@implementation NextFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    if (self.collectionView.bounds.size.height) {
        self.itemSize = self.collectionView.bounds.size;
    }
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


@end
