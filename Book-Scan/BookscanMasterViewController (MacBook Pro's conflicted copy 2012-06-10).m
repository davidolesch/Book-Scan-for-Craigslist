//
//  BookscanMasterViewController.m
//  Book-Scan
//
//  Created by David on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BookscanMasterViewController.h"
#import "BookscanDetailViewController.h"
#import "BookscanCell.h"


@interface BookscanMasterViewController ()
- (void)configureCell:(BookscanCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation BookscanMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

dispatch_queue_t sideQueue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Book Scan", @"Book Scan");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UINib *nib = [UINib nibWithNibName:@"BookscanCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"BookscanCell"];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(presentScanner:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)presentScanner:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    [self presentModalViewController: reader
                            animated: YES];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    [reader dismissModalViewControllerAnimated:YES];
    [self insertNewObjectWithISBN:symbol.data];
}

- (void)insertNewObjectWithISBN:(NSString *)isbn
{
    [self performSelector: @selector(playBeep)
               withObject: nil
               afterDelay: 0.1];
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    [newManagedObject setValue:isbn forKey:@"title"];
    [newManagedObject setValue:isbn forKey:@"isbn13"];
    
    sideQueue = dispatch_queue_create("com.soulemobile.bookscan", NULL);
    dispatch_async(sideQueue, ^{[self saveInformationForISBN:isbn toObject:newManagedObject inContext:context];});
}

- (void)saveInformationForISBN:(NSString *)isbn toObject:(NSManagedObject *)obj inContext:(NSManagedObjectContext *)context
{    
    NSString *xmlBookInfoURLString = [[NSString alloc] initWithFormat:@"http://174.129.239.80/cheggapi/ean.php?ean=%@",[obj valueForKey:@"isbn13"]];
    
    //fetch info from xmlBookInfoURL and set the values for obj.
    
    [self parseXMLFile:xmlBookInfoURLString];
    
    [obj setValue:[currentDictionary valueForKey:@"title"] forKey:@"title"];
    [obj setValue:[currentDictionary valueForKey:@"author"] forKey:@"author"];
    [obj setValue:[currentDictionary valueForKey:@"isbn10"] forKey:@"isbn10"];
    [obj setValue:[currentDictionary valueForKey:@"publicationDate"] forKey:@"publicationDate"];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        [context save:&error];
    });
    [obj setValue:UIImagePNGRepresentation([UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[currentDictionary valueForKey:@"coverURL"]]]]) forKey:@"bookCover"];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        [context save:&error];
    });
}

#pragma mark - Audio

- (void) initAudio
{
    if(beep)
        return;
    NSError *error = nil;
    beep = [[AVAudioPlayer alloc]
            initWithContentsOfURL:
            [[NSBundle mainBundle]
             URLForResource: @"scan"
             withExtension: @"wav"]
            error: &error];
    if(beep){
        beep.volume = .5f;
        [beep prepareToPlay];
    }
}

- (void) playBeep
{
    if(!beep)
        [self initAudio];
    [beep play];
}

#pragma mark - XML Parsing

- (void)parseXMLFile:(NSString *)pathToFile {
    BOOL success;
    currentDictionary = [[NSMutableDictionary alloc] init];
    NSData *xmlURL = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:pathToFile]];
    addressParser = [[NSXMLParser alloc] initWithData:xmlURL];
    [addressParser setDelegate:self];
    [addressParser setShouldResolveExternalEntities:YES];
    success = [addressParser parse];
    if (success) {
        NSLog(@"success");
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"Title"] || [elementName isEqualToString:@"PrimaryAuthor"] || [elementName isEqualToString:@"ISBN"] || [elementName isEqualToString:@"PubDate"] || [elementName isEqualToString:@"ImageSmall"]) {
        currentString = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ( [elementName isEqualToString:@"Title"] ) {
        [currentDictionary setValue:[currentString copy] forKey:@"title"];
    }
    else if ( [elementName isEqualToString:@"PrimaryAuthor"] ) {
        [currentDictionary setValue:[currentString copy] forKey:@"author"];
    }
    else if ( [elementName isEqualToString:@"ISBN"] ) {
        [currentDictionary setValue:[currentString copy] forKey:@"isbn10"];
    }
    else if ( [elementName isEqualToString:@"PubDate"] ) {
        [currentDictionary setValue:[currentString copy] forKey:@"publicationDate"];
    }
    else if ( [elementName isEqualToString:@"ImageSmall"] ) {
        [currentDictionary setValue:[NSString stringWithFormat:@"http://c.cheggcdn.com/%@",[currentString copy]] forKey:@"coverURL"];
    }
    currentString = nil;

    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (BookscanCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookscanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookscanCell"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[BookscanDetailViewController alloc] initWithNibName:@"BookscanDetailViewController_iPhone" bundle:nil];
	    }
        self.detailViewController.detailItem = object;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        self.detailViewController.detailItem = object;
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;            
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(BookscanCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(BookscanCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleLabel.text = [object valueForKey:@"title"];
    cell.authorLabel.text = [object valueForKey:@"author"];
    cell.thumbnailView.image = [UIImage imageWithData:[object valueForKey:@"bookCover"]];

    if ([object valueForKey:@"author"] == nil) {
        [cell.downloadProgress setHidden:NO];
        [cell.downloadProgress setProgress:0.85 animated:YES];
    }
    else {
        [cell.downloadProgress setProgress:0.0 animated:YES];
        [cell.downloadProgress setHidden:YES];
    }
    if ([object valueForKey:@"bookCover"] == nil) {
        [cell.downloadIndicator startAnimating];
    }
    else {
        [cell.downloadIndicator stopAnimating];
    }
}

@end
