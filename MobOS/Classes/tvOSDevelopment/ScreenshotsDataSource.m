//
//  ScreenshotsDataSource.m
//  MobOS
//
//  Created by Ionut Ailincai on 13/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "ScreenshotsDataSource.h"
#import "ScreenshotCollectionViewCell.h"

@implementation ScreenshotsDataSource

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScreenshotCollectionViewCell *cell = (ScreenshotCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdScreenshots forIndexPath:indexPath];
    NSString *screenshotName = [NSString stringWithFormat:@"screenshot%ld.jpg", indexPath.row%5];
    UIImage *screenshotImage = [UIImage imageNamed:screenshotName];
    [cell setScreenshotImage:screenshotImage];
    
    return cell;
}

@end
