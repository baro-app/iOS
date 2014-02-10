//
//  SearchListingsViewController.m
//  Mootch
//
//  Created by Garcia, Fabio (HBO-NS) on 1/7/14.
//  Copyright (c) 2014 Garcia, Fabio (HBO-NS). All rights reserved.
//

#import "SearchListingsViewController.h"
#import "TWTSideMenuViewController.h"
#import "UIImageView+WebCache.h"
#import "ListingTableViewCell.h"

@interface SearchListingsViewController ()

@property NSMutableArray *arrSearchResults;
@property UITableView *searchResults;
@property UISearchBar *searchBar;

@end

static NSString * const kNewSearchCellIdentifier = @"com.flykit.newSearchCell";

@implementation SearchListingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"Search Listings";
    UIBarButtonItem *btnChannels = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    self.navigationItem.leftBarButtonItem = btnChannels;
    
    self.arrSearchResults = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.searchResults = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,480.0f) style:UITableViewStylePlain];
    [self.searchResults registerClass:[ListingTableViewCell class] forCellReuseIdentifier:kNewSearchCellIdentifier];
    self.searchResults.delegate = self;
    self.searchResults.dataSource = self;
    self.searchResults.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.searchResults];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,70.0f,320.0f,44.0f)];
    self.searchBar.delegate = self;
    [self.searchResults setTableHeaderView:self.searchBar];

    [self performSelector:@selector(updateSearch:)];
}

- (void)openMenu {
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (void)updateSearch:(BOOL)update {
    NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
    [mainQueue setMaxConcurrentOperationCount:5];
    NSURL *apiUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://dev.api.mootch.it/listings/search/%@",self.searchBar.text]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:apiUrl];
    [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        if(!error) {
            NSError *parseError;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&parseError];
            if([[response objectForKey:@"success"] isEqualToString:@"true"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.arrSearchResults = [[response objectForKey:@"results"] mutableCopy];
                    NSLog(@"%@",self.arrSearchResults);
                    [self.searchResults reloadData];
                });
            }
        }
    }];
    if(update) [self performSelector:@selector(updateSearch:) withObject:nil afterDelay:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self updateSearch:NO];
    if([self.arrSearchResults count] > 0) [searchBar resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(65, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(65.0, 0.0, (keyboardSize.width), 0.0);
    }
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.searchResults.contentInset = contentInsets;
        self.searchResults.scrollIndicatorInsets = contentInsets;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.searchResults.contentInset = UIEdgeInsetsMake(65, 0.0, 0, 0.0);
        self.searchResults.scrollIndicatorInsets = UIEdgeInsetsMake(65, 0.0, 0, 0.0);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrSearchResults count];
}

- (ListingTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewSearchCellIdentifier forIndexPath:indexPath];
    //if(cell == nil) {
    //    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kNewSearchCellIdentifier];
    //}
    return cell;
}
//First dictResult corresponds to the actual deserialized JSON object representing one listing returned from the php backend
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictResult = [self.arrSearchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictResult objectForKey:@"title"];
    [cell.imageView setImageWithURL:[NSURL URLWithString:[[[dictResult objectForKey:@"images"] objectAtIndex:0] objectForKey:@"image_src"]]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.detailTextLabel.text = @"Something";
    
    UIButton *btnBook = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,0.0f,80.0f,20.0f)];
    [btnBook setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnBook setTitle:@"Book" forState:UIControlStateNormal];
    cell.accessoryView = btnBook;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
