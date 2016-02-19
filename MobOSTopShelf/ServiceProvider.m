//
//  ServiceProvider.m
//  Screenshots
//
//  Created by Ionut Ailincai on 14/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "ServiceProvider.h"

@interface ServiceProvider ()

@end

@implementation ServiceProvider


- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (TVContentItem*) screenshotsSectionItem {
    TVContentIdentifier *screenshotsIdentifier = [[TVContentIdentifier alloc] initWithIdentifier:@"screenshots" container:nil];
    TVContentItem *screenshotsItem = [[TVContentItem alloc] initWithContentIdentifier:screenshotsIdentifier];
    screenshotsItem.title = @"Screenshots";
    
    return screenshotsItem;
}

- (NSArray *) screenshotItemsWithContainer: (TVContentIdentifier*) container {
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"screenshot%d", i];
        TVContentIdentifier *identifier = [[TVContentIdentifier alloc] initWithIdentifier:imageName container:container];
        TVContentItem *item = [[TVContentItem alloc] initWithContentIdentifier:identifier];
        item.title = [NSString stringWithFormat:@"Screenshot %d", i+1];
        item.imageURL = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"jpg"];
        item.imageShape = TVContentItemImageShapeHDTV;
        NSString *urlString = [NSString stringWithFormat:@"mobos://%@", imageName];
        item.displayURL = [NSURL URLWithString: urlString];
        [itemsArray addObject:item];
    }
    
    return itemsArray;
}

#pragma mark - TVTopShelfProvider protocol

- (TVTopShelfContentStyle)topShelfStyle {
    // Return desired Top Shelf style.
    return TVTopShelfContentStyleSectioned;
}

- (NSArray *)topShelfItems {
    // Create an array of TVContentItems.
    
    TVContentItem *screenshotsItem = [self screenshotsSectionItem];
    screenshotsItem.topShelfItems = [self screenshotItemsWithContainer:screenshotsItem.contentIdentifier];
    return  @[screenshotsItem];
}

@end
