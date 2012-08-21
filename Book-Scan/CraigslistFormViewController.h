//
//  CraigslistFormViewController.h
//  Book-Scan
//
//  Created by David on 6/14/12.
//

#import <UIKit/UIKit.h>

@interface CraigslistFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSIndexPath *cityIndex;
@property (strong, nonatomic) NSString *isbn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
