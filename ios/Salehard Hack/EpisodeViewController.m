//
//  EpisodeViewController.m
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "EpisodeViewController.h"
#import "EpisodeInfoViewController.h"
#import "EpisodeQuizViewController.h"
#import <SCLAlertView.h>
#import "InstagramViewController.h"

@interface EpisodeViewController ()

@end

@implementation EpisodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = self;
    
    [self setupViewControllersForPages: self.params];
    
    
    
    [self setViewControllers:@[[self.controllers objectAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)setupViewControllersForPages:(NSArray<NSMutableDictionary*>*)pages {
    NSMutableArray *arr = [NSMutableArray new];
    for (NSMutableDictionary *dic in pages) {
        if ([[dic objectForKey:@"type"] isEqualToString:@"quiz"]) {
            EpisodeQuizViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EpisodeQuiz"];
            vc.params = dic;
            vc.delegate = self;
            [arr addObject:vc];
        } else if ([[dic objectForKey:@"type"] isEqualToString:@"info"]) {
            EpisodeInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EpisodeInfo"];
            vc.params = dic;
            vc.delegate = self;
            [arr addObject:vc];
        } else if ([[dic objectForKey:@"type"] isEqualToString:@"photo"]) {
            InstagramViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"instavc"];
            vc.params = dic;
            vc.delegate = self;
            [arr addObject:vc];
        }
    }
    self.controllers = arr;
}

// DataSource

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger idx = [self.controllers indexOfObject:viewController];
    if (idx <= 0) {
        return nil;
    }
    return [self.controllers objectAtIndex: idx - 1];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger idx = [self.controllers indexOfObject:viewController];
    if (idx >= [self.controllers count] - 1) {
        return nil;
    }
    if ([viewController isKindOfClass:[EpisodeQuizViewController class]]) {
        EpisodeQuizViewController *cnt = (EpisodeQuizViewController*) viewController;
    }
    return [self.controllers objectAtIndex: idx + 1];
}

- (void) GetAchievment: (NSString*)name
{
    AchievmentManager *mgr = [AchievmentManager new];
    if (![mgr SubmitAchiement:name]) return;
    
    NSMutableDictionary *dict = [mgr getAchievment:name];
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(@"Ура!", ^{ /*work here*/ });
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleSuccess)
    .title([NSString stringWithFormat:@"Достижение \"%@\" разблоировано!", [dict objectForKey:@"name"] ])
    .subTitle(@"")
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:self];
    showBuilder.show(builder.alertView, self);
}

@end

