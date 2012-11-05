//
//  MM_DetailViewController.m
//  MM_Notes
//
//  Created by Jamie Thomason on 11/1/12.
//  Copyright (c) 2012 Jamie Thomason. All rights reserved.
//

#import "MM_DetailViewController.h"

@interface MM_DetailViewController () <UITextViewDelegate>
{
    bool        titleSet;
    NSString    *setTitle;
}

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
    
    _noteTextView.frame=CGRectMake(_noteTextView.frame.origin.x, _noteTextView.frame.origin.y, _noteTextView.frame.size.width, 350);
    
}

-(void)saveData
{
    
    // Save the context.
    NSError *error = nil;
    
    if (![_sourceContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

-(void)deleteButton:(id)sender {
    
//    Need this to delete the item
    [_sourceContext deleteObject:_detailItem];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem sourceViewContext: context
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        _sourceContext = context;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        
        // Get date from Context
        NSDate* date = [self.detailItem valueForKey:@"timeStamp"];
        
        // Format the date
        NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSString* dateText;
        dateText = [dateFormatter stringFromDate:date];
        
        // Set the UILabel to be the formatted date
        self.detailDescriptionLabel.text = dateText;
        
        // Get the note text from Context
        //cell.textLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:14]];
        [self.noteTextView setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:15]];
        self.noteTextView.text = [self.detailItem valueForKey:@"noteItem"];
        
        // Determine length of text in textView and assign length to label
        NSUInteger length;
        length = self.noteTextView.text.length;
        characterCountLabel.text = [NSString stringWithFormat:@"%u", length];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    titleSet = YES;
    [self configureView];
    [self.noteTextView becomeFirstResponder];
    [self.navigationController.navigationBar setTintColor:[UIColor brownColor]];
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
    if (length < 25) {
        characterCountLabel.font = [UIFont systemFontOfSize:14];
    }
    else {
        characterCountLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    characterCountLabel.text = [NSString stringWithFormat:@"%u", length];
    doneBarButton.enabled = YES;
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSArray* components = [textView.text componentsSeparatedByString:@"\n"];
    NSString *firstElement = [components objectAtIndex:0];
    self.navigationItem.title = firstElement;
    return true;
//  NSString *title = [[[NSString alloc] init] autorelease];
//  NSArray *component
    
//  component = [_oNoteTextVIew.text componentSearatedByString:@"\n"];
//  int i = 0;
    
//  while (i < [component count] && [component[i] isEqualToString:@"""])
//  {
//  i++
//  }
    
//  title = component[i]
    
    //assign title to naviagtioitem.title
    // [_detailItem setValue:title forKey:@"title"];
    // [self saveContext];

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [_detailItem setValue:_noteTextView.text forKey:@"noteItem"];
    [self saveData];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _noteTextView.frame=CGRectMake(_noteTextView.frame.origin.x, _noteTextView.frame.origin.y, _noteTextView.frame.size.width, 150);
}

@end
