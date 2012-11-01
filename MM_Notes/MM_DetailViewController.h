//
//  MM_DetailViewController.h
//  MM_Notes
//
//  Created by Jamie Thomason on 11/1/12.
//  Copyright (c) 2012 Jamie Thomason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MM_DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
