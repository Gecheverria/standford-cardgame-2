//
//  CGameSetCardDeck.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameSetCardDeck.h"
#import "CGameSetCard.h"

@implementation CGameSetCardDeck

- (instancetype)init {
    
    self = [super init];
    
    if(self) {
        
        for (NSString *symbol in [CGameSetCard symbolStrings]) {
            for (NSString *color in [CGameSetCard colors]) {
                for (NSUInteger number = 1; number <= [CGameSetCard numbers].count; number++) {
                    for (NSString *shading in [CGameSetCard shading]) {
                        CGameSetCard *setCard = [[CGameSetCard alloc] init];
                        
                        setCard.symbol = symbol;
                        setCard.color = color;
                        setCard.number = number;
                        setCard.shading = shading;
                        
                        [self addCard:setCard];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
