//
//  BNRItem.h
//  RandomItems
//
//  Created by Qiushi Li on 5/25/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, copy) NSString *itemName, *serialNumber;

@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;

+ (instancetype) randomItem;

// designated initializer
- (instancetype) initWithItemName: (NSString *)name
                        valueInDollars: (int) value
                        serialNumber: (NSString *)sNumber;

- (instancetype) initWithItemName: (NSString *)name;

- (instancetype) initWithItemName: (NSString *)name
                     serialNumber: (NSString *)sNumber;

@end
