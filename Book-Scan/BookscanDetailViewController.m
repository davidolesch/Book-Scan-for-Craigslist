//
//  BookscanDetailViewController.m
//  Book-Scan
//
//  Created by David on 6/3/12.
//

#import "BookscanDetailViewController.h"
#import "BookscanImageViewController.h"
#import "CraigslistFormViewController.h"

@interface BookscanDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation BookscanDetailViewController

@synthesize detailItem = _detailItem;
@synthesize bookCoverImage, detailedInfoWebView;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSString *detailedInfoHTML = [NSString stringWithFormat:@"<html><body style=\"background:#f7f7f7;\"><b>%@</b><br/><i>%@</i><br/><br/><b>ISBN-10</b> %@<br/><b>ISBN-13</b> %@<br/><b>Published</b> %@</body></html>",[[self.detailItem valueForKey:@"title"] description],[self.detailItem valueForKey:@"author"],[self.detailItem valueForKey:@"isbn10"],[self.detailItem valueForKey:@"isbn13"],[self.detailItem valueForKey:@"publicationDate"]];
        [self.detailedInfoWebView loadHTMLString:detailedInfoHTML baseURL:nil];
        [self setTitle:[[self.detailItem valueForKey:@"title"] description]];
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(postToCraigslist:)];
        [self.navigationItem setRightBarButtonItem:nextButton animated:YES];
        self.bookCoverImage.image = [UIImage imageWithData:[self.detailItem valueForKey:@"bookCover"]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)postToCraigslist:(UIButton *)sender {
    CraigslistFormViewController *cfvc = [[CraigslistFormViewController alloc] initWithNibName:@"CraigslistFormViewController" bundle:nil];

    [cfvc setIsbn:[self.detailItem valueForKey:@"isbn13"]];
    [self.navigationController pushViewController:cfvc animated:YES];
}

- (IBAction)pushImage:(id)sender {
    NSLog(@"pushing image...");
    BookscanImageViewController *ivc = [[BookscanImageViewController alloc] initWithNibName:@"BookscanImageViewController" bundle:nil];
    [ivc setImage:[bookCoverImage image]];
    [self.navigationController pushViewController:ivc animated:YES];
}
@end
