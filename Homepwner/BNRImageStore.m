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
- (NSString *)imagePathForKey:(NSString *)key;
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
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)clearCache {
    [self.dictionary removeAllObjects];
}

- (NSString *)imagePathForKey:(NSString *)key {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [documentDirectories firstObject];
    return [directory stringByAppendingPathComponent:key];
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
    
    NSString *path = [self imagePathForKey:key];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:path atomically:YES];
}

-(UIImage *) imageForKey:(NSString *)key {
    UIImage *image = self.dictionary[key];
    if (!image) {
        NSString *path = [self imagePathForKey:key];
        image = [UIImage imageWithContentsOfFile:path];
        if (image) {
            self.dictionary[key] = image;
        } else {
            NSLog(@"unable to find the image");
        }
    }
    return image;
}

-(void) deleteImageForKey:(NSString *)key {
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    NSString *path = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
@end
