//
//  TVOSViewController.m
//  MobOS
//
//  Created by Ionut Ailincai on 13/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "TVOSViewController.h"

@interface TVOSViewController ()

@end

@implementation TVOSViewController

#pragma mark -
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark IBActions
- (IBAction)doneButtonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
