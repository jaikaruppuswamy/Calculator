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
- (void) addToHistory: (NSString *)str ;
@end

@implementation CalculatorViewController

@synthesize history = _history;
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
        if ([digit isEqualToString:@"."]) {
            NSRange range = [self.display.text rangeOfString:@"."];
            if (range.length != 0) return;
        }
        self.display.text = [self.display.text stringByAppendingString:digit];
        [self addToHistory:digit];
    } else {
        self.display.text = digit; [self addToHistory:digit];
        self.userTyping = TRUE;
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userTyping) [self enterPressed];
    double result = [self.model performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    
    [self addToHistory:[sender.currentTitle stringByAppendingFormat: @" "]];
}

- (IBAction)enterPressed {
    [self.model pushOperand:[self.display.text doubleValue]];
    self.userTyping = NO;
    
    [self addToHistory:@" "];
}

- (IBAction)piPressed {
    //if (self.userTyping) [self enterPressed];
}

- (IBAction)backspacePressed {
    if (self.userTyping) {
        int toIndex = [self.display.text length] - 1;
        self.display.text = [self.display.text substringToIndex:toIndex];
    }
}

- (IBAction)clearPressed {
    self.display.text = @"0"; self.history.text = @"";
    self.userTyping = FALSE;
    [self.model clearAll];
}

- (void) addToHistory: (NSString *)str {
    NSString *newStr = [self.history.text stringByAppendingFormat:str];
//    NSLog(@"length-%d", [newStr length]);
    //TODO: Need to a NSRange substring...
    if ([newStr length] > 20) newStr = [newStr substringFromIndex:1];
    self.history.text = newStr;
}

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
- (IBAction)ePressed:(id)sender {
}

@end
