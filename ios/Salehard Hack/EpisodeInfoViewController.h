//
//  EpisodeInfoViewController.h
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievmentManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface EpisodeInfoViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *SomeLabel;
@property (weak, nonatomic) IBOutlet UITextView *TextView;
@property (strong, nonatomic) NSMutableDictionary * params;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) id<AchievmentDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
