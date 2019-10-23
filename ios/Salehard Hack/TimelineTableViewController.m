//
//  TimelineTableViewController.m
//  salehard
//
//  Created by Maxim Kochukov on 22/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "TimelineTableViewCell.h"
#import "RouteMapViewViewController.h"
#import "DataData.h"
@interface TimelineTableViewController ()
@property RouteMapViewViewController *vc;
@end

@implementation TimelineTableViewController

- (NSDictionary*)makePoint:(NSString*)url withTitle:(NSString*)title {
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:66.53259828914892 longitude:66.66178452929691];
    
    NSArray *steps = @[[NSMutableDictionary dictionaryWithObjects:@[@"Посмотри на жепу",  @"descr", @"https://vpoisketurov.ru/800/600/http/dostoprimechatelnosti-m.ru/wp-content/uploads/2017/07/mam166.jpg", @"info", @"kek"] forKeys:@[@"title", @"text", @"image", @"type", @"achievment"]],
    [NSMutableDictionary dictionaryWithObjects:@[@"Вопрос кек", @"Ты пидор?", @[@"Да", @"Да"], @0, @"quiz", @"pek"] forKeys:@[@"title", @"question", @"answers", @"correct", @"type", @"achievment"]],
    [NSMutableDictionary dictionaryWithObjects:@[@"Посмотри на жепу",  @"aaa", @"https://vpoisketurov.ru/800/600/http/dostoprimechatelnosti-m.ru/wp-content/uploads/2017/07/mam166.jpg", @"info"] forKeys:@[@"title", @"text", @"image", @"type"]],
    [NSMutableDictionary dictionaryWithObjects:@[@"mek", @"instagram"] forKeys:@[@"achievment", @"type"]]
    ];
    
    return [NSDictionary dictionaryWithObjects:@[title, url, loc, steps] forKeys:@[@"title", @"image", @"location", @"steps"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*NSMutableArray * StoryItems = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        [StoryItems addObject:[self makePoint:@"https://vpoisketurov.ru/800/600/http/dostoprimechatelnosti-m.ru/wp-content/uploads/2017/07/mam166.jpg" withTitle:@"Памятник мамонту"]];
    }
    self.StoryItems = StoryItems;
    */
    self.cache = [NSMutableDictionary new];
    DataData *data = [DataData new];
    self.SelectedIndex = [[[data.data objectAtIndex:self.mindex] objectForKey:@"index"]intValue];
    self.StoryItems = [[data.data objectAtIndex:self.mindex] objectForKey:@"chapters"];
}

#pragma mark - Table view data source

- (UIColor*)makeGradient:(NSUInteger)no total:(NSUInteger)total from:(UIColor*)a to:(UIColor*)b {
    CGFloat ared = 0.0, agreen = 0.0, ablue = 0.0, aalpha = 0.0;
    CGFloat bred = 0.0, bgreen = 0.0, bblue = 0.0;
    [a getRed:&ared green:&agreen blue:&ablue alpha:&aalpha];
    [b getRed:&bred green:&bgreen blue:&bblue alpha:&bblue];
    CGFloat c1 = no / (float)(total - 1);
    CGFloat c2 = (total - 1 - no) / (float)(total - 1);
    CGFloat red = (ared * c1 + c2 * bred) / 2;
    CGFloat green = (agreen * c1 + c2 * bgreen) / 2;
    CGFloat blue = (ablue * c1 + c2 * bblue) / 2;
    return [UIColor colorWithRed:red green:green blue:blue alpha:aalpha];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"cells %ld", [self.StoryItems count]);
    return [self.StoryItems count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 437;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineCell" forIndexPath:indexPath];
    
    [cell.UpperLine setHidden:indexPath.row == 0];
    [cell.LowerLine setHidden:indexPath.row == [self.StoryItems count] - 1];
    
    UIColor *c1 = [UIColor colorWithRed:126/255.0 green:65/255.0 blue:138/255.0 alpha:1.0];
    UIColor *c2 = [UIColor colorWithRed:97/255.0 green:59/255.0 blue:191/255.0 alpha:1.0];
    UIColor *cc1 = [self makeGradient:indexPath.row-1 total:[self.StoryItems count] from:c1 to:c2];
    UIColor *cc2 = [self makeGradient:indexPath.row total:[self.StoryItems count] from:c1 to:c2];
    
    [cell.UpperLine setBackgroundColor:c2];
    [cell.LowerLine setBackgroundColor:c2];
    
    NSMutableDictionary *item = [self.StoryItems objectAtIndex:indexPath.row];
    
    
    NSURL *imageUrl = [NSURL URLWithString:(NSString*)[item objectForKey:@"image"]];
    
    if ([self.cache objectForKey:imageUrl]) {
        
        [cell.MainImage setImage:[self.cache objectForKey:imageUrl]];
    } else {
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:imageUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *downloadedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.MainImage.image = downloadedImage;


                CATransition *transition = [CATransition animation];
                transition.duration = .5f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                // [self.ImageView setImage:downloadedImage];
                [self.cache setObject:downloadedImage forKey:imageUrl];
                [cell.MainImage.layer addAnimation:transition forKey:nil];
            });
            
        }];
        [task resume];
    }
    [cell.Title setText:(NSString*)[item objectForKey:@"name"]];
    [cell.MainImage.layer setCornerRadius:8.0];
    [cell.MainImage.layer setMasksToBounds:YES];
    
    UIView *v = cell.BackgroundView;
    // border radius
    [v.layer setCornerRadius:8.0f];

    // drop shadow
    [v.layer setShadowColor:[UIColor blackColor].CGColor];
    [v.layer setShadowOpacity:0.3];
    [v.layer setShadowRadius:5.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    [cell.OverlayView.layer setCornerRadius:8.0];
    [cell.OverlayView setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
    
    [cell.OverlayView setHidden:(indexPath.row < self.SelectedIndex)];
    if (indexPath.row == self.SelectedIndex) {
        [cell.OverlayViewLabel setText:@"Глава откроется на месте"];
    }
    cell.RouteButton.tag = indexPath.row;
    cell.NextButton.tag = indexPath.row;
    [cell.RouteButton addTarget:self action:@selector(ShowRouteToLocationButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.NextButton addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

- (IBAction)nextView:(id)sender {
    NSInteger tag = [(UIButton*) sender tag];
    NSMutableDictionary *dic = (NSMutableDictionary*)[self.StoryItems objectAtIndex:tag];
    //episodes
    EpisodeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"episodes"];
    vc.params = [dic objectForKey:@"episodes"];
    [self showViewController:vc sender:self];
}


- (IBAction)ShowRouteToLocationButton:(id)sender {
    UIButton *btn = (UIButton*) sender;
    NSMutableDictionary *dic = (NSMutableDictionary*)[self.StoryItems objectAtIndex:btn.tag];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:[[[dic objectForKey:@"location"] objectAtIndex:0] floatValue] longitude:[[[dic objectForKey:@"location"] objectAtIndex:1] floatValue]];
    [self ShowRouteToLocation:loc withTitle:[dic objectForKey:@"name"] andAddress:[dic objectForKey:@"address"] ];
}


- (void) ShowRouteToLocation: (CLLocation*) location withTitle:(NSString*)title andAddress:(NSString*) address {
    RouteMapViewViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RouteMapViewViewController"];
    vc.targetLocation = location;
    vc.Title = title;
    vc.Addr = address;
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.navigationItem.title = @"Маршрут";
    
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(close)];
    [self showViewController:navVc sender:self];
    
    _vc = vc;
}

- (void)close {
    [_vc.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
