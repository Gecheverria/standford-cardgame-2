//
//  CGameSetCard.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameSetCard.h"

@implementation CGameSetCard

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
