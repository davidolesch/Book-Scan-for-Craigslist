//
//  CitiesViewController.h
//  Book-Scan
//
//  Created by David on 6/17/12.
//

#import <UIKit/UIKit.h>
#import "CraigslistFormViewController.h"

@interface CitiesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *cities;
@property (weak, nonatomic) CraigslistFormViewController *craigslistForm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil parentForm:(CraigslistFormViewController *)parentForm;

@end
