//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Jai Karuppuswamy on 3/8/12.
//  Copyright (c) 2012 Citi. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorModel.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userTyping;
@property (nonatomic, strong) CalculatorModel *model;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userTyping = _userTyping;
@synthesize model = _model;

- (CalculatorModel *)model {
    if (_model == nil)
        _model = [[CalculatorModel alloc] init];
    return _model;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if (self.userTyping) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userTyping = TRUE;
    }
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userTyping) {
        [self enterPressed];
    }
    double result = [self.model performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

- (IBAction)enterPressed {
    NSLog(@"Entering enterPressed");
    [self.model pushOperand:[self.display.text doubleValue]];
    NSLog(@"operand %g was pushed", self.display.text);
    self.userTyping = NO;
    NSLog(@"Leaving enterPressed");
}
@end
