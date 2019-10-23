//
//  TimelineTableViewCell.h
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@import CoreLocation;


@interface TimelineTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *UpperLine;
@property (weak, nonatomic) IBOutlet UIView *LowerLine;

@property (weak, nonatomic) IBOutlet UIButton *NextButton;

@property (weak, nonatomic) IBOutlet UILabel *Title;

@property (strong, nonatomic) IBOutlet UIImageView *MainImage;
@property (weak, nonatomic) IBOutlet UIView *OverlayView;

@property (weak, nonatomic) IBOutlet UILabel *OverlayViewLabel;

@property (weak, nonatomic) IBOutlet UIButton *RouteButton;

@property (nonatomic) CLLocationCoordinate2D *targetLocation;

@property (weak, nonatomic) IBOutlet UIView *BackgroundView;


@end

NS_ASSUME_NONNULL_END
