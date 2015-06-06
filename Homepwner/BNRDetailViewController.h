//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by Qiushi Li on 6/2/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController
- (instancetype)initWithNewItem:(BOOL)isNew;
@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);
@end
