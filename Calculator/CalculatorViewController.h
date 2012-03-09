//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Jai Karuppuswamy on 3/8/12.
//  Copyright (c) 2012 Citi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
- (IBAction) enterPressed;
@end
