//
//  CGameDeck.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameDeck.h"

@interface CGameDeck();

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation CGameDeck

- (NSMutableArray *)cards {
    
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (void)addCard:(CGameCard *)card atTop:(BOOL)atTop {
    
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
    
}

- (void)addCard:(CGameCard *)card {
    [self addCard:card atTop:NO];
}

- (CGameCard *)drawRandomCard {
    
    CGameCard *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        
        randomCard = self.cards[index];
        
        [self.cards removeObjectAtIndex:index];
        
    }
    
    return randomCard;
    
}

@end
