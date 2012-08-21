//
//  EditableCell.m
//  Book-Scan
//
//  Created by David on 6/14/12.
//

#import "EditableCell.h"

@implementation EditableCell

@synthesize titleLabel, propertyTextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[self textLabel] setText:@"Email"];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setPropertyTextField:[[UITextField alloc] initWithFrame:CGRectMake(70.0,11.0,220.0,20.0)]];
        [self.propertyTextField setTextAlignment:UITextAlignmentRight];
        [self.propertyTextField setTextColor:self.detailTextLabel.textColor];
        [self.propertyTextField setKeyboardType:UIKeyboardTypeEmailAddress];
        [self.propertyTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.propertyTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self.contentView addSubview:propertyTextField];
    }
    return self;
}


@end
