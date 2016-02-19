//
//  ScreenshotCollectionViewCell.h
//  MobOS
//
//  Created by Ionut Ailincai on 13/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kCollectionCellIdScreenshots = @"kCollectionCellIdScreenshots";

@interface ScreenshotCollectionViewCell : UICollectionViewCell

- (void) setScreenshotImage: (UIImage*) screenshotImage;;

@end
