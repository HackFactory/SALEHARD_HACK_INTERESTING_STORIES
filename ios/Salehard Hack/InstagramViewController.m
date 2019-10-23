//
//  InstagramViewController.m
//  Salehard Hack
//
//  Created by Vladislav Shakhray on 23.10.2019.
//  Copyright © 2019 Vladislav Shakhray. All rights reserved.
//

#import "InstagramViewController.h"

@interface InstagramViewController ()

@end

@implementation InstagramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *b = [[UIButton alloc] initWithFrame:_image.frame];
    [b addTarget:self action:@selector(pick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    // Do any additional setup after loading the view.
    self.index = [[self.params objectForKey:@"pid"] intValue];
}

- (void)pick {
    if (_done) {
        [self ig_];
        return;
    }
        
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    // Check if image access is authorized
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // Use delegate methods to get result of photo library -- Look up UIImagePicker delegate methods
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:true completion:nil];
    }
}
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    if (originalImage.imageOrientation != UIImageOrientationUp) {
      UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);
      [originalImage drawInRect:(CGRect){{0, 0}, originalImage.size}];
      originalImage = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
    }
    
    [self sendImageWithMethod:@"insta/upload" image:originalImage parameters:[[NSDictionary alloc] initWithObjects:@[[NSString stringWithFormat:@"%d", _index]] forKeys:@[@"place"]]];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD show];
    }];
    
    _image.hidden = YES;
    _header.hidden = YES;
    _body.hidden = YES;
}

- (void)sendImageWithMethod:(NSString *)method image:(UIImage *)image parameters:(NSDictionary<NSString *, NSString *> *)parameters {
    static NSString *const kBaseURL = @"http://35.228.149.163:5000";
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?", kBaseURL, method];
    for (NSString *key in parameters) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, parameters[key]]];
    }
    
    NSData * binaryImageData = UIImagePNGRepresentation(image);
        
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:@"myfile.png"] atomically:YES];
    
    NSString *path = [basePath stringByAppendingPathComponent:@"myfile.png"];
    //    NSString *jsonpath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"json%d_%d", MIN(self.selectedCountry, 4), self.selectedType] ofType:@"json"];
        
//    NSString *jsonpath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"json1_1", MIN(_selectedCountry, 4), _selectedType] ofType:@"json"];
        
        
    __block id response;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // only needed if the server is not returning JSON; if web service returns JSON, remove this line
    NSURLSessionTask *task = [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSError *error;

            if (![formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"image" fileName:@"myfile.png" mimeType:@"image/png" error:&error]) {
                NSLog(@"error appending part: %@", error);
            }
        
        }  progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSString* array = (NSString*) responseObject[0];
            
//            self.imageViews = [array copy];
            
            [SVProgressHUD dismiss];
            [self updateWithString:array];
//            int t = 4;
            
//            self.loadedImages = imgs;
//
//            if (self.selectedType == 1) {
//                [SVProgressHUD dismiss];
//                [self performSegueWithIdentifier:@"GIFs" sender:self];
//            } else {
//                [SVProgressHUD dismiss];
//                [self performSegueWithIdentifier:@"Stickers" sender:self];
//            }
        } failure:^(NSURLSessionTask *task, NSError *error) {
            NSLog(@"error = %@", error);
        }];
    
//    return response;
}

- (void) updateWithString:(NSString *)string {
    _result.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    _str = string;
    _image.image = [UIImage imageNamed:@"ig"];
    _done = YES;
    _image.hidden = NO;
    
}

- (void) ig_ {
    NSString *achievment = [self.params objectForKey:@"achievement"];
    if (achievment != nil) {
        [self.delegate GetAchievment:achievment];
    }
    
    UIImage *image = _result.image;
    NSURL *urlScheme = [NSURL URLWithString:@"instagram-stories://share"];
    if ([[UIApplication sharedApplication] canOpenURL:urlScheme]) {
    
          // Assign background image asset and attribution link URL to pasteboard
        NSArray *pasteboardItems = @[@
        {@"com.instagram.sharedSticker.backgroundImage" : image,
                                         @"com.instagram.sharedSticker.contentURL" : _str}];
          NSDictionary *pasteboardOptions = @{UIPasteboardOptionExpirationDate : [[NSDate date] dateByAddingTimeInterval:60 * 5]};
          // This call is iOS 10+, can use 'setItems' depending on what versions you support
          [[UIPasteboard generalPasteboard] setItems:pasteboardItems options:pasteboardOptions];
      
          [[UIApplication sharedApplication] openURL:urlScheme options:@{} completionHandler:nil];
    } else {
        // Handle older app versions or app not installed case
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
