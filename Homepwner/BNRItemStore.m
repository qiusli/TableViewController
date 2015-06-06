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
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
        [self.privateItems addObject:@"No More Items!"];
    }
    return self;
}


- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
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
//    BNRItem *item = [BNRItem randomItem];
    BNRItem *item = [[BNRItem alloc] init];
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
