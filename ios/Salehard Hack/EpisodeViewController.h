//
//  EpisodeViewController.h
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievmentManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface EpisodeViewController : UIPageViewController <UIPageViewControllerDataSource, AchievmentDelegate>

@property (strong, nonatomic) NSMutableArray<UIViewController*>* controllers;
@property (strong, nonatomic) NSArray *params;

-(void)GetAchievment:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
