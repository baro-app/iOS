//
//  NewListingViewController.m
//  Mootch
//
//  Created by Garcia, Fabio (HBO-NS) on 1/7/14.
//  Copyright (c) 2014 Garcia, Fabio (HBO-NS). All rights reserved.
//

#import "NewListingViewController.h"

@interface NewListingViewController ()

@property UITableView *inputTable;
@property NSMutableArray *arrDisplaying;

@property UIImageView *imgFirst;
@property UITextField *txtTitle;
@property UITextField *txtTags;
@property UITextField *txtRate;
@property UITextField *txtDesc;

@end

static NSString * const kNewListingCellIdentifier = @"com.flykit.newListingCell";

@implementation NewListingViewController

@synthesize inputTable, arrDisplaying;

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
    
    self.arrDisplaying = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.inputTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,480.0f) style:UITableViewStylePlain];
    [self.inputTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kNewListingCellIdentifier];
    [self.view addSubview:self.inputTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.inputTable.contentInset = contentInsets;
        self.inputTable.scrollIndicatorInsets = contentInsets;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.inputTable.contentInset = UIEdgeInsetsZero;
        self.inputTable.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:kNewListingCellIdentifier forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
