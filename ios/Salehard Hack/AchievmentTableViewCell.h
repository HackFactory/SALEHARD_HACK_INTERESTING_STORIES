//
//  AchievmentTableViewCell.h
//  salehard
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AchievmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *view;

@end

NS_ASSUME_NONNULL_END
