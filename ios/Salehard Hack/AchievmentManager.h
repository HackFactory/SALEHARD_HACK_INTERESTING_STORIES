//
//  AchievmentManager.h
//  salehard
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AchievmentDelegate <NSObject>
- (void) GetAchievment: (NSString*)name;
@end

@interface AchievmentManager : NSObject


- (void) setupAchievments: (NSMutableArray<NSMutableDictionary*>*) achievments;
- (NSMutableArray<NSMutableDictionary*>*) listAchievments;
- (NSMutableArray* _Nullable) getAchievment: (NSString*) name;

- (BOOL) SubmitAchiement: (NSString*)name;

@end

NS_ASSUME_NONNULL_END
