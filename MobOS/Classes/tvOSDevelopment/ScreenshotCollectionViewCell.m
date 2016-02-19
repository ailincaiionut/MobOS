//
//  ScreenshotCollectionViewCell.m
//  MobOS
//
//  Created by Ionut Ailincai on 13/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "ScreenshotCollectionViewCell.h"

@interface ScreenshotCollectionViewCell() {
    IBOutlet UIImageView *_screenshotImageView;
}

@end

@implementation ScreenshotCollectionViewCell

- (void)setScreenshotImage:(UIImage *)screenshotImage {
    _screenshotImageView.image = screenshotImage;
}

@end
