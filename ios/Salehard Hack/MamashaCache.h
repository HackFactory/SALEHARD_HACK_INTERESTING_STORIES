//
//  MamashaCache.h
//  Salehard Hack
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MamashaCache : NSObject
@property (strong, nonatomic) NSMutableDictionary*cache;

- (UIImage *)GetImage:(NSString*)key;
- (void)SetImage:(NSString*)key image:(UIImage*)value;
+ (MamashaCache*)sharedInstance;
@end

NS_ASSUME_NONNULL_END
