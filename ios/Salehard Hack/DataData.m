//
//  DataData.m
//  Salehard Hack
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import "DataData.h"

@implementation DataData
@synthesize data;

- (instancetype) init {
    self = [super init];
    if (self) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSString* cnt = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData * jsonData = [cnt dataUsingEncoding:NSUTF8StringEncoding];
        NSError * error=nil;
        NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        self.data = parsedData;
    }
    return self;
}

@end
