//
//  ViewController.h
//  wave
//
//  Created by Yvan Scher on 9/19/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) IBOutlet UITextView *textDisplayField;
-(IBAction) handleSearchButtonPressed:(id)sender;


@end

