//
//  FocusableControl.m
//  MobOS
//
//  Created by Ionut Ailincai on 13/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "FocusableControl.h"

#define kCenterTilt 5
#define kAngleTilt 10

@interface FocusableControl() {
    UIVisualEffectView *_blurBackgroundView;
    
    IBInspectable BOOL _scaleOnFocus;
    IBInspectable BOOL _tiltHorizontal;
    IBInspectable BOOL _tiltVertical;
}

@end

@implementation FocusableControl

#pragma mark -
#pragma mark UIFocusEnvironment
- (BOOL)canBecomeFocused {
    return YES;
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    [coordinator addCoordinatedAnimations:^{
        if(context.nextFocusedView == self) {
            [self addBackgroundBlur];
            [self addTiltEffects];
            if(_scaleOnFocus) {
                self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            }
        } else if (context.previouslyFocusedView == self) {
            [self removeBackgroundBlur];
            [self removeTiltEffects];
            if(_scaleOnFocus) {
                self.transform = CGAffineTransformIdentity;
            }
        }
    } completion:nil];
}

#pragma mark -
#pragma mark BackgroundEffect
- (void) addBackgroundBlur {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurBackgroundView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurBackgroundView.layer.cornerRadius = 5;
    _blurBackgroundView.layer.masksToBounds = YES;
    _blurBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self insertSubview:_blurBackgroundView atIndex:0];
    
    [_blurBackgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = true;
    [_blurBackgroundView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = true;
    [_blurBackgroundView.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
    [_blurBackgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
}

- (void) removeBackgroundBlur {
    [_blurBackgroundView removeFromSuperview];
    _blurBackgroundView = nil;
}

#pragma mark -
#pragma mark Tilting
- (void) addTiltEffects {
    NSMutableArray *motionEffectsArray = [NSMutableArray array];
    if(_tiltHorizontal) {
        [motionEffectsArray addObjectsFromArray:[self horizontalEffectsArray]];
     }
    
    if(_tiltVertical) {
        [motionEffectsArray addObjectsFromArray:[self verticalEffectsArray]];
    }
    
    UIMotionEffectGroup *effectGroup = [[UIMotionEffectGroup alloc] init];
    effectGroup.motionEffects = motionEffectsArray;
    [self addMotionEffect:effectGroup];
}

- (NSArray*) horizontalEffectsArray {
    NSMutableArray *horizontalEffectsArray = [NSMutableArray array];
    [horizontalEffectsArray addObject:[self interpolatingMotionEffectForKeyPath:@"center.x" motionEffectType:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis minValue:@(kCenterTilt) maxValue:@(kCenterTilt)]];
    
    NSValue *minTransform = [self perspectiveTransformValueWithAngle:-kAngleTilt x:0 y:1 z:0];
    NSValue *maxTransform = [self perspectiveTransformValueWithAngle:kAngleTilt x:0 y:1 z:0];
    
    [horizontalEffectsArray addObject:[self interpolatingMotionEffectForKeyPath:@"layer.transform" motionEffectType:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis minValue:minTransform maxValue:maxTransform]];
    return horizontalEffectsArray;
}

- (NSArray*) verticalEffectsArray {
    NSMutableArray *verticalEffectsArray = [NSMutableArray array];
    [verticalEffectsArray addObject:[self interpolatingMotionEffectForKeyPath:@"center.y" motionEffectType:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis minValue:@(-kCenterTilt) maxValue:@(kCenterTilt)]];
    
    NSValue *minTransform = [self perspectiveTransformValueWithAngle:kAngleTilt x:1 y:0 z:0];
    NSValue *maxTransform = [self perspectiveTransformValueWithAngle:-kAngleTilt x:1 y:0 z:0];
    
    [verticalEffectsArray addObject:[self interpolatingMotionEffectForKeyPath:@"layer.transform" motionEffectType:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis minValue:minTransform maxValue:maxTransform]];
    
    return verticalEffectsArray;
}

- (void) removeTiltEffects {
    for(UIMotionEffect *effect in self.motionEffects) {
        [self removeMotionEffect:effect];
    }
}

- (UIInterpolatingMotionEffect*) interpolatingMotionEffectForKeyPath: (NSString*) keypath motionEffectType: (UIInterpolatingMotionEffectType) effectType minValue: (id) minValue maxValue: (id) maxValue {
    UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:keypath type:effectType];
    motionEffect.minimumRelativeValue = minValue;
    motionEffect.maximumRelativeValue = maxValue;
    
    return motionEffect;
}

- (NSValue*) perspectiveTransformValueWithAngle: (CGFloat) angle x:(CGFloat)x y:(CGFloat)y z:(CGFloat) z {
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 1 / 2500.0;
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, angle * M_PI / 180, x, y, z);
    
    return [NSValue valueWithCATransform3D:perspectiveTransform];
}


#pragma mark -
#pragma mark Custom Setters/Getters
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(!_scaleOnFocus) {
        return;
    }
    
    CGFloat newScale = (highlighted) ? 1.0 : 1.1;
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, newScale, newScale);
    }];
}


#pragma mark -
#pragma mark Touches
- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    [super pressesBegan:presses withEvent:event];
    self.highlighted = YES;
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    [super pressesCancelled:presses withEvent:event];
    self.highlighted = NO;
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event {
    [super pressesEnded:presses withEvent:event];
    self.highlighted = NO;
    
    UIPress *press = presses.anyObject;
    if (press.type == UIPressTypeSelect) {
        [self sendActionsForControlEvents:UIControlEventPrimaryActionTriggered];
    }
}


@end
