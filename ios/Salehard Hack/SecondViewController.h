//
//  SecondViewController.h
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 22.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *question;

@property NSMutableArray<NSString *> *variants;
@property (weak, nonatomic) IBOutlet UILabel *answer;


@property int index;

@end

