//
//  EpisodeInfoViewController.m
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "EpisodeInfoViewController.h"



@interface EpisodeInfoViewController ()
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) CGFloat str;
@end

@implementation EpisodeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[self ImageView] setBackgroundColor:[UIColor colorWithRed:126/255.0 green:65/255.0 blue:138/255.0 alpha:1.0]];
    
    [[self SomeLabel] setText: [self.params objectForKey:@"title"]];
    [[self TextView] setText:[self.params objectForKey:@"text"]];
    
    self.ScrollViewHeightConstraint.constant = [self.params objectForKey:@"text"] == nil || [[self.params objectForKey:@"text"] isEqualToString:@""]  ? 19 : 1000;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    self.ScrollView.delegate = self;
    
    
    NSURL *imageUrl = [NSURL URLWithString:(NSString*)[self.params objectForKey:@"image"]];
    
    if (self.image) {
        self.ImageView.image = self.image;
    } else {
        if ([self.params objectForKey:@"image"] != nil) {
            NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:imageUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                UIImage *downloadedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
                self.image = downloadedImage;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //
                    self.ImageView.image = downloadedImage;
                    

                    CATransition *transition = [CATransition animation];
                    transition.duration = 1.0f;
                    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    transition.type = kCATransitionFade;
                    // [self.ImageView setImage:downloadedImage];
                    
                    [self.ImageView.layer addAnimation:transition forKey:nil];
                });
            
            }];
            [task resume];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *achievment = [self.params objectForKey:@"achievement"];
    if (achievment) {
        [self.delegate GetAchievment:achievment];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint pos = [scrollView contentOffset];
    CGFloat str = MIN(1.0, pos.y / 350);
    if (fabs(str - self.str) > 0.1) {
        UIImage *img = [self blurredImageWithImage:self.image andStrength:str];
        [self.ImageView setImage:img];
        self.str = str;
    }
    
}

- (UIImage *)blurredImageWithImage:(UIImage *)sourceImage andStrength:(CGFloat)str{

    //  Create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];

    //  Setting up Gaussian Blur
    CIFilter *filter = [CIFilter filterWithName:@"CIBoxBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:str * 15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];

    /*  CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches
     *  up exactly to the bounds of our original image */
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];

    UIImage *retVal = [UIImage imageWithCGImage:cgImage];

    if (cgImage) {
        CGImageRelease(cgImage);
    }

    return retVal;
}

@end

