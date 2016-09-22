//
//  CGamePlayingCardDeck.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGamePlayingCardDeck.h"
#import "CGamePlayingCard.h"

@implementation CGamePlayingCardDeck

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        for (NSString *suit in [CGamePlayingCard validSuits]) {
            for (NSUInteger rank = 1;rank <= [CGamePlayingCard maxRanks]; rank++) {
                
                CGamePlayingCard * card = [[CGamePlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
