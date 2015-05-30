//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Qiushi Li on 5/29/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;
@end

@implementation BNRItemStore

+ (instancetype) sharedStore {
    static BNRItemStore *itemStore = nil;
    if (!itemStore) {
        itemStore = [[BNRItemStore alloc] initPrivate];
    }
    return itemStore;
}

- (instancetype) init {
    @throw [NSException exceptionWithName:@"single" reason:@"use + [BNRItemshre sharedStore] " userInfo:nil];
}

- (instancetype) initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *) allItems {
    return self.privateItems;
}

- (BNRItem *) createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

@end
