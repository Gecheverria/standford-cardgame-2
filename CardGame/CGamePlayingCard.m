//
//  CGamePlayingCard.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGamePlayingCard.h"

@implementation CGamePlayingCard

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    for (CGamePlayingCard *otherCard in otherCards) {
        if (otherCard.rank == self.rank) {
            score += 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
    }

    if ([otherCards count] == 2) {
        CGamePlayingCard *firstCard = [otherCards objectAtIndex:0];
        CGamePlayingCard *secondCard = [otherCards objectAtIndex:1];
        
        if (firstCard.rank == secondCard.rank) {
            score += 4;
        } else if ([firstCard.suit isEqualToString:secondCard.suit]) {
            score += 1;
        }
    }

    return score;
}

-(NSString *) contents {
    NSArray *rankStrings = [CGamePlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRanks {
    return [[self rankStrings] count] - 1;
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
    if ([[CGamePlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *) setSuit {
    return _suit ? _suit :@"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [CGamePlayingCard maxRanks]) {
        _rank = rank;
    }
}

@end
