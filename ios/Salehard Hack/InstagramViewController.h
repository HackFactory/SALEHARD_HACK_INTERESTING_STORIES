//
//  InstagramViewController.h
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 23.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "AchievmentManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface InstagramViewController : UIViewController <UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property int index;
@property NSString *str;
@property BOOL done;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIImageView *result;

@property (strong, nonatomic) NSMutableDictionary * params;
@property (weak, nonatomic) id<AchievmentDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
