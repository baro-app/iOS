//
//  MenuViewController.h
//  Mootch
//
//  Created by Garcia, Fabio (HBO-NS) on 1/9/14.
//  Copyright (c) 2014 Garcia, Fabio (HBO-NS). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchListingsViewController.h"


@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SearchListingsViewController *searchListingViewController;

@end
