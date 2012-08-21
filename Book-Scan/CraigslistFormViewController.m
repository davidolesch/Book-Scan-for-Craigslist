//
//  CraigslistFormViewController.m
//  Book-Scan
//
//  Created by David on 6/14/12.
//

#import "CraigslistFormViewController.h"
#import "EditableCell.h"
#import "CitiesViewController.h"
#import "FinishedViewController.h"

@interface CraigslistFormViewController ()

@end

@implementation CraigslistFormViewController
@synthesize tableView;

@synthesize email, city, cityIndex, isbn;

dispatch_queue_t sideQueue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Post to Craigslist"];
        UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleDone target:self action:@selector(sendToCraigslist:)];
        [self.navigationItem setRightBarButtonItem:postButton animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    city = [[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] detailTextLabel] text];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] setSelected:NO animated:YES];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([indexPath row] == 0) {
        EditableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"EditableCell"];
        if (cell == nil) {
            cell = [[EditableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"EditableCell"];
            [cell.propertyTextField setDelegate:self];
            [cell.propertyTextField setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"Book-ScanEmailPrefKey"]]; 
        }
        return cell;
    }
    else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CraigslistFormCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CraigslistFormCell"];
        }
        [[cell textLabel] setText:@"City"];
        [[cell detailTextLabel] setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"Book-ScanCityNamePrefKey"]];
        city = [[NSUserDefaults standardUserDefaults] valueForKey:@"Book-ScanCityNamePrefKey"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        //email
        [[(EditableCell *)[self.tableView cellForRowAtIndexPath:indexPath] propertyTextField] becomeFirstResponder];
    }
    else if ([indexPath row] == 1) {
        //push state view controller
        [[(EditableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] propertyTextField] resignFirstResponder];
        [self.navigationController pushViewController:[[CitiesViewController alloc] initWithNibName:@"CitiesViewController" bundle:nil parentForm:self] animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Post to Craigslist";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"Tap save to post this book to Craigslist";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setValue:[textField text] forKey:@"Book-ScanEmailPrefKey"];
    [textField resignFirstResponder];
    return YES;
}

- (void)sendToCraigslist:(id)sender
{
    email = [[(EditableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] propertyTextField] text];
    if (![email isEqualToString:@""] && email) {
        [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"Book-ScanEmailPrefKey"];
        FinishedViewController *ccvc = [[FinishedViewController alloc] initWithNibName:@"FinishedViewController" bundle:nil];
        [self.navigationController pushViewController:ccvc animated:YES];
        sideQueue = dispatch_queue_create("com.davidolesch.bookscan", NULL);
        dispatch_async(sideQueue, ^{[self submitToAWS];});
    }
}

- (void)submitToAWS
{
    NSString *URLString = [[NSString alloc] initWithFormat:@"http://path/to/your/craigslist/API/?isbn=%@&email=%@&location=%@",isbn,email,city];//see README.txt to set this up
    NSString *fileURLString = [URLString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSData *fileData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fileURLString]];
    NSString *returnedFileContents=[[NSString alloc] initWithData:fileData encoding:NSASCIIStringEncoding];   
    NSString *returnedString = [[NSString alloc] initWithFormat:returnedFileContents];
    NSLog(@"returnedString = %@",returnedString);
    NSLog(@"CHECK THAT THE ABOVE LINE SAYS 'Your ad has been sent to craigslist'.");

    NSLog(@"%@",fileURLString);

    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"successfully submitted %@ to AWS",isbn);
    });
}

@end
