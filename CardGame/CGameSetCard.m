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
        
        //Use NSSet because a Set is composed of unique objects, hence no duplicates, so we can apply the set logic more easily instead of a huge if.
        NSSet *symbol = [[NSSet alloc] initWithArray:@[self.symbol, sc.symbol, tc.symbol]];
        NSSet *colors = [[NSSet alloc] initWithArray:@[self.color, sc.color, tc.color]];
        NSSet *shadings = [[NSSet alloc] initWithArray:@[self.shading, sc.shading, tc.shading]];
        NSSet *numbers = [[NSSet alloc] initWithArray:@[[NSNumber numberWithInt: (int)self.number], [NSNumber numberWithInt: (int)sc.number], [NSNumber numberWithInt: (int)tc.number]]];
        
        //More easy to check if it doesn't comply, since it only takes 1 condition for it to not be a set, instead of checking both 1 and 3.
        if (([symbol count] == 2) || ([colors count] == 2) || ([shadings count] == 2) || ([numbers count] == 2)) {
            score = 0;
        } else {
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
