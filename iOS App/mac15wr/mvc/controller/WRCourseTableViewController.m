//
//  WRCourseTableViewController.m
//  mac15wr
//
//  Created by Alex on 2/13/15.
//  Copyright (c) 2015 mac15wr. All rights reserved.
//


#import "WRCourseTableViewController.h"
#import "WRCourseDViewController.h"


@interface WRCourseTableViewController ()

@end

@implementation WRCourseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma test
    //show navi bar
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.mutableCourses=[WRRealmCourse allObjects];
    
    

        
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.mutableCourses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WRCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courselistcell" forIndexPath:indexPath];
    // Configure the cell...
    WRRealmCourse *course= [self.mutableCourses objectAtIndex:indexPath.row];
    cell.courseTileLabel.text=course.title;
    cell.courseSysNumLabel.text=course.sis_course_id;
    cell.courseDesLabel.text=course.desc;
    cell.courseCredit.text=[NSString stringWithFormat:@"%ld", (long)course.min_units];
//    cell.textLabel.text=@"aa";
    
    
    return cell;
}

- (IBAction)backToMainView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
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





- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"courseDetails"]) {
        UINavigationController *nav = [segue destinationViewController];
        WRCourseDViewController* userViewController = (WRCourseDViewController *) nav.topViewController;
        userViewController.courseTableViewDelegate = self;
        userViewController.courseSelected = [self.mutableCourses objectAtIndex:[[self.tableview indexPathForSelectedRow] row]];
    }
}


@end
