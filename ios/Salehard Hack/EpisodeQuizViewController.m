//
//  EpisodeQuizViewController.m
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "EpisodeQuizViewController.h"

@interface EpisodeQuizViewController ()

@end

@implementation EpisodeQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.win = false;
    // Do any additional setup after loading the view.
    self.labels = @[self.answerText1, self.answerText2,self.answerText3, self.answerText4];
    self.images = @[self.answerImg1, self.anwerImg2, self.answerImg3, self.answerImg4];
    self.views = @[self.answerView1, self.answerView2, self.answerView3, self.answerView4];
    
    [self.titleLbl setText:[self.params objectForKey:@"title"]];
    [self.question  setText:[self.params objectForKey:@"question"]];
    
    self.button1.tag = 0;
    self.button2.tag = 1;
    self.button3.tag = 2;
    self.button4.tag = 3;
    
    self.correct = [(NSNumber*)[self.params objectForKey:@"correct"] integerValue];
    
    NSArray<NSMutableDictionary*> *answers = (NSArray<NSMutableDictionary*> *)[self.params objectForKey:@"answers"];
    for (int i = 0; i < 4; i++){
        if (i >= [answers count]) {
            [[self.views objectAtIndex:i] setHidden:YES];
            continue;
        }
        [[self.labels objectAtIndex:i] setText:(NSString*)[answers objectAtIndex:i]];
        [[self.views objectAtIndex:i].layer setCornerRadius:16.0f];
        
    }
}
- (IBAction)ButtonClicked:(id)sender {
    NSInteger tag = [(UIButton*)sender tag];
    for (int i = 0; i < 4; i++) {
        UIImageView *img = (UIImageView*)[self.images objectAtIndex:i];
        
        if (i == tag && i == self.correct) {
            self.win = true;
            NSString *achievment = [self.params objectForKey:@"achievement"];
            if (achievment != nil) {
                [self.delegate GetAchievment:achievment];
            }
            [img setImage:[UIImage imageNamed:@"icons8-checked-104.png"]];
            [self.button1 setEnabled:NO];
            [self.button2 setEnabled:NO];
            [self.button3 setEnabled:NO];
            [self.button4 setEnabled:NO];
        } else if (i == tag) {
            [img setImage:[UIImage imageNamed:@"icons8-cancel-128.png"]];
        } else {
            [img setImage:[UIImage systemImageNamed:@"circle"]];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
