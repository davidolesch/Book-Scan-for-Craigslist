//
//  BookscanCell.h
//  Book-Scan
//
//  Created by David on 6/3/12.
//

#import <Foundation/Foundation.h>

@interface BookscanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *downloadIndicator;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;

@end
