//
//  BNRChangeDateViewController.m
//  Homepwner
//
//  Created by Qiushi Li on 6/2/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "BNRChangeDateViewController.h"
#import "BNRDetailViewController.h"

@interface BNRChangeDateViewController ()
@end

@implementation BNRChangeDateViewController
- (IBAction)datePicker:(id)sender {
    NSDate *dateChosen = [sender date];
    self.item.dateCreated = dateChosen;
}
@end
