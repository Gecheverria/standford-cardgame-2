//
//  CGamePlayingCard.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGamePlayingCard.h"

@implementation CGamePlayingCard

//Para nuestro Matching game, hay que sobreescribir el metodo de CGameCard para comparar correctamente nuestras cartas
- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    //Por el momento comparamos una carta
    if ([otherCards count] == 1) {
        
        //Si se encuentra una carta en nuestro arreglo de otherCards, creamos una nueva carta de juego asignandole esta carta con el argumento "firstObject"que es como [array objectAtIndex:0], solo que no va a parar si el arreglo esta vacio. El problema de esto es que firsObject retorna un tipo id, por lo que si de alguna manera se retorna algo queno sea una carta, se trabaria el programa.
        
        //Usaremos introspection con un condicional para chequear si el objeto es un PlayingCard usando isKindOfClass (heredado de NSObject)
        id card = [otherCards firstObject];
        
        if ([card isKindOfClass:[CGamePlayingCard class]]) {
            
            //Si es de tipo CGamePlayingCard, hacemos type casting al id card
            CGamePlayingCard *otherCard = (CGamePlayingCard *)card;
            
            //Luego comparamos otherCard con la tarjeta en "self"
            if (otherCard.rank == self.rank) {
                score = 4;
            } else if ([otherCard.suit isEqualToString:self.suit]) {
                score = 1;
            }
        }
    }
    
    return score;
}

//Sobreescribimos la propiedad contents de CGameCard
-(NSString *) contents {
    
    NSArray *rankStrings = [CGamePlayingCard rankStrings];
    //los self.ranky self.suit vienen de sus getters, que son llenados en el playingcarddeck.
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

//A continuacion 3 metodos de clase, que son principalmente de utilidad para definir valores
+ (NSArray *)validSuits {
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRanks {
    return [[self rankStrings] count] - 1;
}

//Debemos sintetizar suit porque sobreescribimos su getter y setter
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
