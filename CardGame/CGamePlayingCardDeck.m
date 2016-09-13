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
        //Necesitamos nuestro deck de juego, por lo que creamos nuestras tarjetas mediante las propiedades definidas en CGamePlayingCard.
        for (NSString *suit in [CGamePlayingCard validSuits]) {
            for (NSUInteger rank = 1;rank <= [CGamePlayingCard maxRanks]; rank++) {
                //Inicializamos el objeto de CGamePlayingCard
                CGamePlayingCard * card = [[CGamePlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                //Agregamos nuestra carta generada mediante el metodo de addCard a un MutableArray, heredado de CGameDeck
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
