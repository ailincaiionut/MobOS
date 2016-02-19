//
//  PresentationDetailsViewController.m
//  MobOS
//
//  Created by Ionut Ailincai on 13/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "PresentationDetailsViewController.h"

@interface PresentationDetailsViewController (){
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIView *_representativeImageContainer;
    IBOutlet UIView *_speakersContainer;
    IBOutlet UICollectionView *_screenshotsCollectionView;
    
    IBOutlet UIButton *_pricingButton;
    IBOutlet UIButton *_moreDetailsButton;
}

@end

@implementation PresentationDetailsViewController

#pragma mark -
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addFocusGuides];
    [self showFocusGuides];
}

- (void) showFocusGuides {
    for(UIFocusGuide *focusGuide in _scrollView.layoutGuides) {
        if([focusGuide isKindOfClass:[UIFocusGuide class]] == NO) {
            continue;
        }
        
        CALayer *focusGuideLayer = [[CALayer alloc] init];
        focusGuideLayer.frame = focusGuide.layoutFrame;
        focusGuideLayer.borderColor = [UIColor redColor].CGColor;
        focusGuideLayer.borderWidth = 1;
        [_scrollView.layer addSublayer:focusGuideLayer];
    }
}

#pragma mark -
#pragma mark Focus Guides
- (void) addFocusGuides{
    [self addCollectionTopFocusGuide];
    [self addCollectionBottomLeftFocusGuide];
    [self addCollectionBottomRightFocusGuide];
    [self addSpeakersRightFocusGuide];
}

- (UIFocusGuide*) focusGuideWithPrefferedFocusedView :(UIView*) viewToFocus {
    UIFocusGuide *focusGuide = [[UIFocusGuide alloc] init];
    focusGuide.preferredFocusedView = viewToFocus;
    [_scrollView addLayoutGuide:focusGuide];
    return focusGuide;
}

- (void)  addCollectionTopFocusGuide {
    UIFocusGuide *focusGuide = [self focusGuideWithPrefferedFocusedView: _speakersContainer];
    
    [focusGuide.bottomAnchor constraintEqualToAnchor: _screenshotsCollectionView.topAnchor  constant: -50 ].active = YES;
    [focusGuide.trailingAnchor constraintEqualToAnchor:_screenshotsCollectionView.trailingAnchor].active = YES;
    [focusGuide.leadingAnchor constraintEqualToAnchor: _speakersContainer.trailingAnchor constant: 50 ].active = YES;
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10]];
}

- (void) addCollectionBottomLeftFocusGuide  {
    UIFocusGuide *focusGuide = [self focusGuideWithPrefferedFocusedView: _pricingButton];

    [focusGuide.topAnchor constraintEqualToAnchor:_screenshotsCollectionView.bottomAnchor constant:30].active = YES;
    [focusGuide.leadingAnchor constraintEqualToAnchor:_screenshotsCollectionView.leadingAnchor constant:30].active = YES;
    [focusGuide.trailingAnchor constraintEqualToAnchor:_pricingButton.leadingAnchor constant:-20].active = YES;
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10]];
}

- (void) addCollectionBottomRightFocusGuide {
    UIFocusGuide *focusGuide = [self focusGuideWithPrefferedFocusedView: _moreDetailsButton];
    [focusGuide.topAnchor constraintEqualToAnchor:_screenshotsCollectionView.bottomAnchor constant:30].active = YES;
    [focusGuide.trailingAnchor constraintEqualToAnchor:_screenshotsCollectionView.trailingAnchor].active = YES;
    [focusGuide.leadingAnchor constraintEqualToAnchor:_moreDetailsButton.trailingAnchor].active = YES;
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10]];
}

- (void) addSpeakersRightFocusGuide {
    UIFocusGuide *focusGuide = [self focusGuideWithPrefferedFocusedView: _representativeImageContainer];

    [focusGuide.topAnchor constraintEqualToAnchor:_speakersContainer.topAnchor constant:50].active = YES;
    [focusGuide.bottomAnchor constraintEqualToAnchor:_speakersContainer.bottomAnchor].active = YES;
    [focusGuide.leadingAnchor constraintEqualToAnchor:_speakersContainer.trailingAnchor constant:50].active = YES;

    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10]];
}


@end
