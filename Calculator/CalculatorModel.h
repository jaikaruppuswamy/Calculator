//
//  CalculatorModel.h
//  Calculator
//
//  Created by Jai Karuppuswamy on 3/8/12.
//  Copyright (c) 2012 Citi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

@property (readonly) id program;

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearAll;

+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;

@end
