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
    [super dealloc];
}

-(void)doneButton:(id)sender {
    
    // Ask don why this works.  How come you have to add the endEditing:yes?  ResignFirstResponder alone didn't work. 
    [self.view endEditing:YES];
    [noteTextView resignFirstResponder];
    doneBarButton.enabled = NO;
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

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
    
    NSUInteger length;
    length = [noteTextView.text length];
    characterCountLabel.text = [NSString stringWithFormat:@"%u", length];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
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
    
    characterCountLabel.text = [NSString stringWithFormat:@"%u", length];
    doneBarButton.enabled = YES;
}


@end
