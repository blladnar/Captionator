//
//  CaptionPreview.m
//  Captionator
//
//  Created by Randall Brown on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CaptionPreview.h"

@interface CaptionPreview()
-(UIImage*)getImage:(UIImage*)image withCaption:(NSString*)captionString;
@end

@implementation CaptionPreview

- (id)initWithImage:(UIImage*)image
{
   self = [super init];
   imageToPreview = image;
   return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(NSString*)captionString
{
   int r = arc4random() % [captions count];
   return [captions objectAtIndex:r];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

   imagePreview.image = imageToPreview;
   
   captions = [[NSUserDefaults standardUserDefaults] arrayForKey:@"captions"];
   
   if( !captions )
   {
      captions = [[NSArray alloc] initWithObjects: @"Let's get rapey!", @"Normal Penis", nil];
      [[NSUserDefaults standardUserDefaults] setObject:captions forKey:@"captions"];
      [[NSUserDefaults standardUserDefaults] synchronize];
   }
   
   [self getNewCaption:nil];
}


- (void)viewDidUnload
{
    imagePreview = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIImage*)getImage:(UIImage*)image withCaption:(NSString*)captionString
{
   UIGraphicsBeginImageContext([image size]);
   [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
   
   CGFloat captionFontSize = 300;
   CGSize captionSize = [captionString sizeWithFont:[UIFont boldSystemFontOfSize:captionFontSize]];
   NSLog(@"%f %f", captionSize.width, image.size.width);
   while( captionSize.width > image.size.width )
   {
      captionFontSize -= 5;
      captionSize = [captionString sizeWithFont:[UIFont boldSystemFontOfSize:captionFontSize]];
   }
   
   CGRect captionRect = CGRectMake((image.size.width - captionSize.width)/2.0, (image.size.height * .95)-captionSize.height, captionSize.width, captionSize.height);
   
   
   
   
   CGContextRef context = UIGraphicsGetCurrentContext();
   CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
   CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
   CGContextSetLineWidth(context, 3.0f);
   CGContextSetTextDrawingMode(context, kCGTextFillStroke);
   
   [captionString drawInRect:captionRect withFont:[UIFont boldSystemFontOfSize:captionFontSize]];
   
   UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
   
   UIGraphicsEndImageContext();
   return outputImage;
}

- (IBAction)getNewCaption:(id)sender 
{
   imagePreview.image = [self getImage:imageToPreview withCaption:[self captionString]];
}

- (IBAction)saveImage:(id)sender 
{
   UIImageWriteToSavedPhotosAlbum(imagePreview.image, nil, nil, nil);
}
@end
