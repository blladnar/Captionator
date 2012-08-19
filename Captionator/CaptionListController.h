//
//  CaptionListController.h
//  Captionator
//
//  Created by Randall Brown on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptionListController : UIViewController
{
   __weak IBOutlet UITextField *captionField;
   
}
- (IBAction)done:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)addCaption:(id)sender;
@end
