//
//  TVHistoryViewController.m
//  MobOS
//
//  Created by Ionut Ailincai on 10/02/16.
//  Copyright © 2016 MobOS. All rights reserved.
//

#import "TVHistoryViewController.h"

@interface TVHistoryViewController ()

@end

@implementation TVHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark IBActions
- (IBAction)doneButtonPressed:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
