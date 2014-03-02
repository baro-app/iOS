//
//  MenuViewController.m
//  Mootch
//
//  Created by Garcia, Fabio (HBO-NS) on 1/9/14.
//  Copyright (c) 2014 Garcia, Fabio (HBO-NS). All rights reserved.
//

#import "MenuViewController.h"
#import "TWTSideMenuViewController.h"

@interface MenuViewController ()
    @property UITableView *tableView;
@end

static NSString * const kMenuTableViewCellIdentifier = @"com.flykit.menuViewCell";

@implementation MenuViewController

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if(!self.searchListingViewController) {
            SearchListingsViewController *newSearchListingViewController = [[SearchListingsViewController alloc] init];
            self.searchListingViewController = newSearchListingViewController;
        }
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    
    //self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graybgtexture.jpg"]];
    //self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 500.0f, 1000.0f)];
    bgView.backgroundColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:1.0f];
    [self.view addSubview:bgView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5.0f, 120.0f, 235.0f, 440.0f) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMenuTableViewCellIdentifier];
}


#pragma mark UITextFieldDelegate methods


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tview dequeueReusableCellWithIdentifier:kMenuTableViewCellIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor lightGrayColor];
    int index = indexPath.row;
    if(index == 0) {
        cell.textLabel.text = @"Search Listings";
    } else if(index ==1) {
        cell.textLabel.text = @"My Listings";
    } else if(index ==2) {
        cell.textLabel.text = @"My Bookings";
    } else if(index ==3) {
        cell.textLabel.text = @"Messages";
    } else if(index ==4) {
        cell.textLabel.text = @"Settings";
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    int index = indexPath.row;
    if(index == 0) {
        [self  ]
    }
    else if(index == 1) {
        
    }
    else if(index == 2) {
        
    }
    else if(index == 3) {
        
    }
    else if(index == 4) {
        
    }
    
}

@end
