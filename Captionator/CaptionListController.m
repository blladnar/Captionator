//
//  CaptionListController.m
//  Captionator
//
//  Created by Randall Brown on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CaptionListController.h"

@implementation CaptionListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    captionField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)done:(id)sender 
{
   [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)reset:(id)sender 
{
   [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"captions"];
   
   [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)addCaption:(id)sender 
{
   
   NSMutableArray *captions = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"captions"]];
   
   
   [captions addObject:captionField.text];
   
   [[NSUserDefaults standardUserDefaults] setObject:captions forKey:@"captions"];
   
   [[NSUserDefaults standardUserDefaults] synchronize];
   
   captionField.text = @"";
   
}
@end
