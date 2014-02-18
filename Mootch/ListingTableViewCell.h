//
//  ListingTableViewCell.h
//  Mootch
//
//  Created by Tristan on 2/7/14.
//  Copyright (c) 2014 Garcia, Fabio (HBO-NS). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingTableViewCell : UITableViewCell
/*
 Should these be NSMutableStrings? Once we get them from the backend they won't change right?
 Unless we want to be using these cells in a part of the app where posters are able to edit
 their listings? In which case they would need to be mutable/we would need to manually
 handle their copying.
 */
@property (strong, nonatomic) UILabel *listingTitle;
@property (strong, nonatomic) UILabel *listingDescription;
@property (strong, nonatomic) UIImageView *listingImage;
@property (strong, nonatomic) UILabel *listingTags;
@property (strong, nonatomic) UILabel *listingRate;
/*
 Following are geographic properties of the listing. City and state dummies for now,
 But Core Location data types will be better eventually for real lat-long locations
 */
@property (weak, nonatomic) NSString *listingCity;
@property (weak, nonatomic) NSString *listingState;
//@property (weak, nonatomic) CLLocationCoordinate2D *listingLocation;

-(void)setCellValues:(NSDictionary *)dictionary;


@end
