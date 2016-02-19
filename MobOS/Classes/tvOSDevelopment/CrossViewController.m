//
//  CrossViewController.m
//  MobOS
//
//  Created by Ionut Ailincai on 12/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "CrossViewController.h"

#define kLayoutSize 20

@interface CrossViewController () {
    IBOutlet UIButton *_topButton;
    IBOutlet UIButton *_leftButton;
    IBOutlet UIButton *_bottomButton;
    IBOutlet UIButton *_rightButton;
    IBOutlet UIButton *_centerButton;
    
    IBOutlet UIView *_containerView;
    
    BOOL _focusGuidesVisible;
    NSMutableArray *_focusGuidesLayersArray;
}

@end

@implementation CrossViewController

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _focusGuidesLayersArray = [NSMutableArray array];
    [self addFocusGuides];
}

#pragma mark -
#pragma mark Utils
- (void) showFocusGuides {
    for(UIFocusGuide *focusGuide in self.view.layoutGuides) {
        if([focusGuide isKindOfClass:[UIFocusGuide class]] == NO) {
            continue;
        }
        
        CALayer *focusGuideLayer = [[CALayer alloc] init];
        focusGuideLayer.frame = focusGuide.layoutFrame;
        focusGuideLayer.borderColor = [UIColor redColor].CGColor;
        focusGuideLayer.borderWidth = 1;
        [self.view.layer addSublayer:focusGuideLayer];
        [_focusGuidesLayersArray addObject:focusGuideLayer];
    }
}

- (void) hideFocusGuides {
    [_focusGuidesLayersArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_focusGuidesLayersArray removeAllObjects];
}

- (void) addFocusGuideWithCenter: (CGPoint) center targetFocusView: (UIView*) view {
    UIFocusGuide *focusGuide = [[UIFocusGuide alloc] init];
    focusGuide.preferredFocusedView = view;
    [self.view addLayoutGuide:focusGuide];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kLayoutSize]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kLayoutSize]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeLeading multiplier:1 constant:center.x]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:focusGuide attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1 constant:center.y]];
}

- (void) addFocusGuides {
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMinX(_topButton.frame)-kLayoutSize, CGRectGetMidY(_topButton.frame)) targetFocusView:_leftButton];
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMinX(_bottomButton.frame)-kLayoutSize, CGRectGetMidY(_bottomButton.frame)) targetFocusView:_leftButton];
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMaxX(_topButton.frame)+kLayoutSize, CGRectGetMidY(_topButton.frame)) targetFocusView:_rightButton];
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMaxX(_bottomButton.frame)+kLayoutSize, CGRectGetMidY(_bottomButton.frame)) targetFocusView:_rightButton];
    
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMidX(_leftButton.frame), CGRectGetMinY(_leftButton.frame)-kLayoutSize) targetFocusView:_topButton];
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMidX(_rightButton.frame), CGRectGetMinY(_rightButton.frame) - kLayoutSize) targetFocusView:_topButton];
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMidX(_leftButton.frame), CGRectGetMaxY(_leftButton.frame) + kLayoutSize) targetFocusView:_bottomButton];
    [self addFocusGuideWithCenter:CGPointMake(CGRectGetMidX(_rightButton.frame), CGRectGetMaxY(_rightButton.frame) + kLayoutSize) targetFocusView:_bottomButton];
}

#pragma mark -
#pragma mark UIFocusEnvironment
- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
}

#pragma mark -
#pragma mark IBAction
- (IBAction)enterButtonPressed:(id)sender {
    _focusGuidesVisible = !_focusGuidesVisible;
    if(_focusGuidesVisible) {
        [self showFocusGuides];
    } else {
        [self hideFocusGuides];
    }
}


@end
