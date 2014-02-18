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
        
        
        self.listingImage = [[UIImageView alloc] init];
        [self.listingImage setFrame:CGRectMake(5.0f,5.0f, 45.0f, 55.0f)];
        [self addSubview:self.listingImage];

        self.listingTitle = [[UILabel alloc] init];
        [self.listingTitle setFrame:CGRectMake(65.0f, 5.0f, 240.0f, 18.0f)];
        [self.listingTitle setFont:[UIFont systemFontOfSize:18.0f]];
        [self addSubview:self.listingTitle];
        
        
        self.listingTags = [[UILabel alloc] init];
        [self.listingTags setFrame:CGRectMake(65.0f, 28.0f, 240.0f, 18.0f)];
        [self.listingTags setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:self.listingTags];
        
        self.listingRate = [[UILabel alloc] init];
        [self.listingRate setFrame:CGRectMake(65.0f, 51.0f, 112.5f, 18.0f)];
        [self addSubview:self.listingRate];
        
        
        UIButton *btnBook = [[UIButton alloc] initWithFrame:CGRectMake(192.5f,51.0f,112.5f,18.0f)];
        [btnBook setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnBook setTitle:@"Book" forState:UIControlStateNormal];
        [[btnBook layer] setBorderWidth:1.0f];
        [[btnBook layer] setBorderColor:[UIColor grayColor].CGColor];
        [self addSubview:btnBook];
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
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.listingImage setImage:image];

     
    NSArray *tagArray = [dictionary objectForKey:@"tags"];
    NSMutableString *tagString = [[NSMutableString alloc] initWithString:@"Tags: "];
    for(int i = 0; i < tagArray.count; i++){
        [tagString appendString:[tagArray[i] objectForKey:@"tag"]];
        [tagString appendString:@" "];
    }
    [self.listingTags setText:tagString];
    
    float rateFloat = [[dictionary objectForKey:@"rate"] floatValue];
    rateFloat = rateFloat/100.0f;
    
    [self.listingRate setText:[NSString stringWithFormat:@"%d",(int)rateFloat]];
}

@end
