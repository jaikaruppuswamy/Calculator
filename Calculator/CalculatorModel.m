//
//  CalculatorModel.m
//  Calculator
//
//  Created by Jai Karuppuswamy on 3/8/12.
//  Copyright (c) 2012 Citi. All rights reserved.
//

#import "CalculatorModel.h"
@interface CalculatorModel()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorModel

@synthesize programStack = _programStack;

- (NSMutableArray *)operandStack {
    if (_programStack == nil)
        _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (id)program {
    return [self.program copy];
}

- (void)pushOperand:(double)operand {
    NSNumber *operandObj = [NSNumber numberWithDouble:operand];
    [self.programStack addObject:operandObj];
}

- (double)popOperand {
    NSNumber *operandObj = [self.programStack lastObject];
    if (operandObj)
        [self.programStack removeLastObject];
    return operandObj.doubleValue;
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:self.program];
    return [CalculatorModel runProgram:self.program];
}

- (void)clearAll {
    [self.operandStack removeAllObjects];
}

+ (NSString *)descriptionOfProgram:(id)program {
    return @"TODO";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffStack:stack];
            result = [self popOperandOffStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffStack:stack];
            if (divisor) {
                result = [self popOperandOffStack:stack] / divisor;
            } else {
                result = 0;
            }
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"log"]) {
            result = log([self popOperandOffStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffStack:stack]);
        }

    }
    
    return result;
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

@end
