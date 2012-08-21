//
//  BookscanMasterViewController.h
//  Book-Scan
//
//  Created by David on 6/3/12.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@class BookscanDetailViewController;

#import <CoreData/CoreData.h>

@interface BookscanMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, ZBarReaderDelegate, NSXMLParserDelegate>
{
    NSXMLParser *addressParser;
    NSMutableString *currentString;
    NSMutableDictionary *currentDictionary;
    AVAudioPlayer *beep;
}

@property (strong, nonatomic) BookscanDetailViewController *detailViewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
