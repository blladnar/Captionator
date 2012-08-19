//
//  ViewController.h
//  Captionator
//
//  Created by Randall Brown on 8/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate>
{
   
}
- (IBAction)takePicture:(id)sender;
- (IBAction)choosePicture:(id)sender;
- (IBAction)addCaptions:(id)sender;

@end
