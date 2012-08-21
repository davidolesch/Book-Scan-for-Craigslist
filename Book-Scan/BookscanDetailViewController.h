//
//  BookscanDetailViewController.h
//  Book-Scan
//
//  Created by David on 6/3/12.
//

#import <UIKit/UIKit.h>

@interface BookscanDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UIImageView *bookCoverImage;
@property (strong, nonatomic) IBOutlet UIWebView *detailedInfoWebView;
- (IBAction)postToCraigslist:(UIButton *)sender;
- (IBAction)sellToChegg:(UIButton *)sender;
- (IBAction)pushImage:(id)sender;

@end
