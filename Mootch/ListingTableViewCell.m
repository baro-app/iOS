//
//  ListingTableViewCell.m
//  Mootch
//
//  Created by Tristan on 2/7/14.
//  Copyright (c) 2014 Garcia, Fabio (HBO-NS). All rights reserved.
//

#import "ListingTableViewCell.h"

@implementation ListingTableViewCell
@synthesize listingTitle = _listingTitle;
@synthesize listingDescription = _listingDescription;
@synthesize listingTags = _listingTags;
@synthesize listingRate = _listingRate;
@synthesize listingCity = _listingCity;
@synthesize listingState = _listingState;
@synthesize listingImage = _listingImage;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id) initWithListingTitle:(NSString *)title description:(NSString *)description image:(UIImage *)image tags:(NSDictionary *)tags rate:(float)rate
{
    if(self = [super init]) {
        self.listingTitle = title;
        self.listingDescription = description;
        self.listingImage = image;
        self.listingTags = tags;
        self.listingRate = rate;
        [self.imageView setImage:image];
        self.textLabel.text = self.listingTitle;
        self.detailTextLabel.text = self.description;
    }
    else
        return nil;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
