//
//  MM_DetailViewController.m
//  MM_Notes
//
//  Created by Jamie Thomason on 11/1/12.
//  Copyright (c) 2012 Jamie Thomason. All rights reserved.
//

#import "MM_DetailViewController.h"

@interface MM_DetailViewController () <UITextViewDelegate>
- (void)configureView;
@end

@implementation MM_DetailViewController

- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [_noteTextView release];
    [super dealloc];
}

-(void)doneButton:(id)sender {
    
    // Ask don why this works.  How come you have to add the endEditing:yes?  ResignFirstResponder alone didn't work. 
    [self.view endEditing:YES];
    [self.noteTextView resignFirstResponder];
    doneBarButton.enabled = NO;
    [_detailItem setValue:_noteTextView.text forKey:@"noteItem"];
    
}

-(void)deleteButton:(id)sender {

//    [self.detailItem deleteObject:_detailItem];
//    [managedObjectContext deleteObject:entry];

    
//    Need this to delete the item  
    [self.navigationController popToRootViewControllerAnimated:YES];


}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }
}

// Consider refactoring and replacing the time formatting in the configureView methods with the following:
//-(NSString* )formatDateString
//{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
//    NSString *formattedString = [dateFormatter stringFromDate:[self.detailItem valueForKey:@"timeStamp"]];
//    //        secondLabel.text = timeString;
//    [dateFormatter release];
//    return formattedString;
//}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd hh:mm a"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        self.detailDescriptionLabel.text = [dateFormatter stringFromDate:[self.detailItem valueForKey:@"timeStamp"]];
        self.noteTextView.text = [self.detailItem valueForKey:@"noteItem"];
        [dateFormatter release];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd hh:mm a"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    self.detailDescriptionLabel.text = [dateFormatter stringFromDate:[self.detailItem valueForKey:@"timeStamp"]];
    //        secondLabel.text = timeString;
    [dateFormatter release];
    
    
    NSUInteger length;
    length = _noteTextView.text.length;
    characterCountLabel.text = [NSString stringWithFormat:@"%u", length];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self.noteTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSUInteger length;

    length = [textView.text length];
    if (length < 20) {
        self.navigationItem.title = textView.text;
    }
    if (length < 25)
    {
        characterCountLabel.font = [UIFont systemFontOfSize:14];
    }
    else
    {
        characterCountLabel.font = [UIFont boldSystemFontOfSize:14];
    }

    characterCountLabel.text = [NSString stringWithFormat:@"%u", length];
    doneBarButton.enabled = YES;
}


@end
