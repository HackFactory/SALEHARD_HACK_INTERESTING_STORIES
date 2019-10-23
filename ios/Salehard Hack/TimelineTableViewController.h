//
//  TimelineTableViewController.h
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EpisodeViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TimelineTableViewController : UITableViewController

@property(strong, nonatomic) NSMutableArray *StoryItems;
@property(nonatomic) int SelectedIndex;
@property (nonatomic) NSInteger mindex;
@property (nonatomic) NSMutableDictionary *cache;
@end

NS_ASSUME_NONNULL_END
