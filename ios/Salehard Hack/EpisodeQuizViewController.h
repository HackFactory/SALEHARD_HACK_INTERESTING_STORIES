//
//  EpisodeQuizViewController.h
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AchievmentManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface EpisodeQuizViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UILabel *answerText1;
@property (weak, nonatomic) IBOutlet UILabel *answerText2;
@property (weak, nonatomic) IBOutlet UILabel *answerText3;
@property (weak, nonatomic) IBOutlet UILabel *answerText4;

@property (weak, nonatomic) IBOutlet UIImageView *answerImg1;
@property (weak, nonatomic) IBOutlet UIImageView *anwerImg2;
@property (weak, nonatomic) IBOutlet UIImageView *answerImg3;
@property (weak, nonatomic) IBOutlet UIImageView *answerImg4;

@property (weak, nonatomic) IBOutlet UIView *answerView1;
@property (weak, nonatomic) IBOutlet UIView *answerView2;
@property (weak, nonatomic) IBOutlet UIView *answerView3;
@property (weak, nonatomic) IBOutlet UIView *answerView4;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@property (strong, nonatomic) NSMutableDictionary * params;
@property (weak, nonatomic) id<AchievmentDelegate> delegate;

@property (strong, nonatomic) NSArray<UILabel*> *labels;
@property (strong, nonatomic) NSArray<UIImageView*> *images;
@property (strong, nonatomic) NSArray<UIView*> *views;

@property (nonatomic) NSUInteger correct;
@property (nonatomic) BOOL win;


@end

NS_ASSUME_NONNULL_END
