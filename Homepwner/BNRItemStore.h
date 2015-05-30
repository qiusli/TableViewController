//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Qiushi Li on 5/29/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject
@property (nonatomic, weak) NSArray *allItems;

+ (instancetype) sharedStore;
- (BNRItem *) createItem;
@end
