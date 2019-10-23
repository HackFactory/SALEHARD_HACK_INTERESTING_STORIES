//
//  MamashaCache.m
//  Salehard Hack
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import "MamashaCache.h"

@implementation MamashaCache
+ (MamashaCache*)sharedInstance {
    static MamashaCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init {
    if (self = [super init]) {
        self.cache = [NSMutableDictionary new];
    }
    return self;
}

- (UIImage *)GetImage:(NSString*)key {
    return [self.cache objectForKey:key];
}

- (void)SetImage:(NSString*)key image:(UIImage*)value {
    return [self.cache setObject:value forKey:key];
}

@end
