//
//  AchievmentTableViewController.m
//  salehard
//
//  Created by Maxim Kochukov on 23/10/2019.
//  Copyright © 2019 Maxim Kochukov. All rights reserved.
//

#import "AchievmentTableViewController.h"
#import "AchievmentTableViewCell.h"
#import "AchievmentManager.h"
@interface AchievmentTableViewController ()

@end

@implementation AchievmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AchievmentManager *mgr = [AchievmentManager new];
    return [[mgr listAchievments] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AchievmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"achi" forIndexPath:indexPath];
    AchievmentManager *mgr = [AchievmentManager new];
    NSArray<NSMutableDictionary*>* achivs = [mgr listAchievments];
    cell.label.text = [[achivs objectAtIndex:indexPath.row] objectForKey:@"name"];
    [cell.image setImage:[UIImage imageNamed:[[achivs objectAtIndex:indexPath.row] objectForKey:@"image"]]];
    if ([[[achivs objectAtIndex:indexPath.row] objectForKey:@"solved"] boolValue]) {
        cell.view.backgroundColor = [UIColor colorWithRed:126/255.0 green:65/255.0 blue:138/255.0 alpha:1.0];
        [cell.label setTextColor:[UIColor whiteColor]];
    } else {
        cell.view.backgroundColor = [UIColor whiteColor];
         [cell.label setTextColor:[UIColor grayColor]];
    }
    UIView *v = cell.view;

    // border radius
    [v.layer setCornerRadius:16.0f];

    // border
    [v.layer setBorderColor:[UIColor colorWithRed:126/255.0 green:65/255.0 blue:138/255.0 alpha:1.0].CGColor];
    [v.layer setBorderWidth:2.5f];

    // drop shadow
    [v.layer setShadowColor:[UIColor grayColor].CGColor];
    [v.layer setShadowOpacity:0.3];
    [v.layer setShadowRadius:5.0];
    [v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [cell.image.layer setCornerRadius:30.0];
    [cell.image.layer setMasksToBounds:YES];
    
    return cell;
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
