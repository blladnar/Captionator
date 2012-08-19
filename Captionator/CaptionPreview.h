//
//  CaptionPreview.h
//  Captionator
//
//  Created by Randall Brown on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptionPreview : UIViewController
{
   __weak IBOutlet UIImageView *imagePreview;
   UIImage *imageToPreview;
   NSArray *captions;
   
}
- (id)initWithImage:(UIImage*)image;
- (IBAction)getNewCaption:(id)sender;
- (IBAction)saveImage:(id)sender;

@end
