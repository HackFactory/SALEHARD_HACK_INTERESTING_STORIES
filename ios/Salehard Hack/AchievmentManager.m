//
//  AchievmentManager.m
//  salehard
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "AchievmentManager.h"
#import <SCLAlertView.h>
@implementation AchievmentManager

- (void) setupAchievments:(NSMutableArray<NSMutableDictionary *> *)achievments {
    NSMutableDictionary *dicts = [NSMutableDictionary new];
    for (NSMutableDictionary *item in achievments) {
        [item setObject:[NSNumber numberWithBool:false] forKey:@"solved"];
        [dicts setValue:item forKey:[item objectForKey:@"id"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dicts forKey:@"achievments"];
}

- (NSMutableArray<NSMutableDictionary*>*) listAchievments {
    NSMutableArray *res = [NSMutableArray new];
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"achievments"];
    for (NSString * value in [dict allValues]) {
        [res addObject:value];
    }
    return res;
}

- (BOOL) SubmitAchiement: (NSString*)name {
    NSMutableDictionary *dict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"achievments"] mutableCopy];
    NSMutableDictionary *item = [[dict objectForKey:name] mutableCopy];
    BOOL res = [[item objectForKey:@"solved"] boolValue];
    [item setObject:[NSNumber numberWithBool:true] forKey:@"solved"];
    [dict setObject:item forKey:name];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"achievments"];
    
    return !res;
}

- (NSMutableArray*) getAchievment: (NSString*) name {
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"achievments"];
    NSMutableDictionary *item = [[dict objectForKey:name] mutableCopy];
    return item;
}


@end
