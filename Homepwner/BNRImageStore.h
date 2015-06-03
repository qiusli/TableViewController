//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Qiushi Li on 6/2/15.
//  Copyright (c) 2015 BigNerdRanch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+(instancetype) sharedStore;
-(void) setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void) deleteImageForKey:(NSString *)key;
@end
