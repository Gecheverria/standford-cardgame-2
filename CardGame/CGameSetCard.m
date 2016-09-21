//
//  CGameSetCard.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameSetCard.h"

@implementation CGameSetCard

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    if ([otherCards count] == 2) {
        
        CGameSetCard *sc = [otherCards objectAtIndex:0];
        CGameSetCard *tc = [otherCards objectAtIndex:1];
        
        if (
            ([self.symbol isEqualToString:sc.symbol] && [self.symbol isEqualToString:tc.symbol] && [sc.symbol isEqualToString:tc.symbol])
            ||
            (![self.symbol isEqualToString:sc.symbol] && ![self.symbol isEqualToString:tc.symbol] && ![sc.symbol isEqualToString:tc.symbol])
            ) {
            
            NSLog(@"They all have the same symbol, or they have three different symbols.");
            score = 1;
            
        } else
            
        if (
            ([self.color isEqualToString:sc.color] && [self.color isEqualToString:tc.color] && [sc.color isEqualToString:tc.color])
            ||
            (![self.color isEqualToString:sc.color] && ![self.color isEqualToString:tc.color] && ![sc.color isEqualToString:tc.color])
            ) {
            NSLog(@"They all have the same color, or they have three different colors.");
            score = 1;
        } else
            
        if (
            (self.number == sc.number && self.number == tc.number && sc.number == tc.number)
            ||
            (self.number != sc.number && self.number != tc.number && sc.number != tc.number)
            ) {
            NSLog(@"They all have the same number, or they have three different numbers.");
            score = 1;
        } else
            
        if (
            ([self.shading isEqualToString:sc.shading] && [self.shading isEqualToString:tc.shading] && [sc.shading isEqualToString:tc.shading])
            ||
            (![self.shading isEqualToString:sc.shading] && ![self.shading isEqualToString:tc.shading] && ![sc.shading isEqualToString:tc.shading])
            ) {
            NSLog(@"They all have the same shading, or they have three different shadings.");
            score = 1;
        }
        
    }
    
    return score;
}

//Class methods
+ (NSArray *)symbolStrings {
    return @[@"●",@"◼︎",@"▲"];
}

+ (NSArray *)colors {
    return @[@"red",@"green",@"blue"];
}

+ (NSArray *)numbers {
    return @[@1, @2, @3];
}

+ (NSArray *)shading {
    return @[@"solid", @"outline", @"alpha"];
}

//Set Card Properties getters
- (NSString *)contents {
    return [NSString stringWithFormat:@"%@ %@ %lu %@", self.symbol, self.color, (unsigned long)self.number, self.shading];
}

- (NSString *)simbolo {
    return [NSString stringWithFormat:@"%@", self.symbol];
}

- (NSString *)colour {
    return [NSString stringWithFormat:@"%@", self.color];
}

- (NSUInteger)numero {
    return self.number;
}

- (NSString *)style {
    return [NSString stringWithFormat:@"%@", self.shading];
}


@end
