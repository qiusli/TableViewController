//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Qiushi Li on 6/2/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end


@implementation BNRImageStore
-(instancetype) init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use [BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype) initPrivate {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+(instancetype) sharedStore {
    static BNRImageStore *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[self alloc] initPrivate];
    });
    return store;
}

-(void) setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

-(UIImage *) imageForKey:(NSString *)key {
    return self.dictionary[key];
}

-(void) deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}
@end
