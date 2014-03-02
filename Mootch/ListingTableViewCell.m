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
        
        self.listingTitle = [[UILabel alloc] init];
        self.listingDescription= [[UILabel alloc] init];
        self.listingTags = [[UILabel alloc] init];
        self.listingImage = [[UIImageView alloc] init];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellValues:(NSDictionary *) dictionary
{
    NSString *titleString = [dictionary objectForKey:@"title"];
    [self.listingTitle setText:titleString];
    [self.listingDescription setText:[dictionary objectForKey:@"description"]];
    NSString *imageURLString = [[[dictionary objectForKey:@"images"] objectAtIndex:0] objectForKey:@"image_src"];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageURLString];
    NSData *rawImageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *listingImage = [UIImage imageWithData:rawImageData];
    self.imageView.image = listingImage;
    NSArray *tagArray = [dictionary objectForKey:@"tags"];
    NSMutableString *tagString = [[NSMutableString alloc] initWithString:@"Tags: "];
    for(int i = 0; i < tagArray.count; i++){
        [tagString appendString:[tagArray[i] objectForKey:@"tag"]];
        [tagString appendString:@" "];
    }
    self.listingTags.text = tagString;
    self.listingRate = [[dictionary objectForKey:@"rate"] floatValue];
    [self.imageView setFrame:CGRectMake(0,0, 44.0f, 44.0f)];
    [self.imageView setImage:self.listingImage.image];
    [self.contentView setFrame:CGRectMake(44.0f, 0.0f, 200.0f, 44.0f)];
    [self.contentView addSubview:self.listingTitle];
    [self.contentView addSubview:self.listingDescription];
    [self.contentView addSubview:self.listingTags];
    
    
    UIButton *btnBook = [[UIButton alloc] initWithFrame:CGRectMake(144.0f,20.0f,76.0f,20.0f)];
    [btnBook setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnBook setTitle:@"Book" forState:UIControlStateNormal];
    
    NSLog(self.listingDescription.text);
    NSLog(self.listingTitle.text);
    NSLog(self.listingTags.text);

    
    [self.accessoryView addSubview:btnBook];
    
    
    
}

@end
