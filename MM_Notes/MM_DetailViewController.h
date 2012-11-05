//
//  MM_DetailViewController.h
//  MM_Notes
//
//  Created by Jamie Thomason on 11/1/12.
//  Copyright (c) 2012 Jamie Thomason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MM_DetailViewController : UIViewController
{
    IBOutlet    UILabel*            characterCountLabel;
    IBOutlet    UIBarButtonItem*    doneBarButton;
//    IBOutlet    UITextView*        noteTextView;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, retain) IBOutlet UITextView *noteTextView;

@property (strong, nonatomic) id sourceContext;


-(IBAction)doneButton:(id)sender;
-(IBAction)deleteButton:(id)sender;

@end
