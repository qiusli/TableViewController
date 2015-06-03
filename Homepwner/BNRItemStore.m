//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Qiushi Li on 5/29/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

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
        [self.privateItems addObject:@"No More Items!"];
    }
    return self;
}

- (void) removeItem:(BNRItem *)item {
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (NSArray *) allItems {
    return self.privateItems;
}

- (BNRItem *) createItem {
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems insertObject:item atIndex:[self.privateItems count] - 1];
//    [self.privateItems addObject:item];
    return item;
}

- (void) moveItemFrom:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}
@end
