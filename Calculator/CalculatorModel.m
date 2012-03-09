//
//  CalculatorModel.m
//  Calculator
//
//  Created by Jai Karuppuswamy on 3/8/12.
//  Copyright (c) 2012 Citi. All rights reserved.
//

#import "CalculatorModel.h"
@interface CalculatorModel()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorModel

@synthesize operandStack = _operandStack;

- (NSMutableArray *) operandStack {
    if (_operandStack == nil)
        _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}
- (void) pushOperand:(double)operand {
    NSNumber *operandObj = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObj];
}

- (double) popOperand {
    NSNumber *operandObj = [self.operandStack lastObject];
    if (operandObj)
        [self.operandStack removeLastObject];
    return operandObj.doubleValue;
}
- (double) performOperation:(NSString *)operation {
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        result = [self popOperand] / divisor;
    }
    
    [self pushOperand:result];
    return result;
}
@end
