//
//  CGameCardMatchingGame.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameCardMatchingGame.h"

@interface CGameCardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *status;
@property (strong, nonatomic) NSMutableArray *cards; //of CGameCard

@end

@implementation CGameCardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck :(CGameDeck *)deck {
    
    self = [super init];
    
    if (self) {
        self.matchType = 0;
        
        self.status = @"";
        
        for (int i = 0; i < count; i++) {

            CGameCard *card = [deck drawRandomCard];
            
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
            }
        }
    }
    
    return self;
    
}

- (CGameCard *)cardAtIndex:(NSUInteger)index {
    return (index <[self.cards count]) ? self.cards[index] : nil;
}

static const int MISS_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    CGameCard *card = [self cardAtIndex:index];
    if (!card.isMatched) {

        if (card.isChosen) {
            card.chosen = NO;
        } else {
            self.status = [NSString stringWithFormat:@"%@ Selected", card.contents];
            
            for (CGameCard *otherCard in self.cards) {
                
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    int matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        int bonus = matchScore * MATCH_BONUS;
                        self.score += bonus;
                        
                        card.matched = YES;
                        otherCard.matched = YES;
                        
                        self.status = [NSString stringWithFormat:@"Matched %@ %@ for %ld points!", card.contents, otherCard.contents, (long)bonus];
                        
                    } else {
                        self.score -= MISS_PENALTY;
                        
                        self.status = [NSString stringWithFormat:@"%@ %@ don't match! %ld score penalty!", card.contents, otherCard.contents, (long)MISS_PENALTY];
                        
                        otherCard.chosen = NO;
                    }
                    break;
                    
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            
        }
    }
}

@end
