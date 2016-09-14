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
@property (strong, nonatomic) NSMutableArray *cards; //De objeto CGameCard

@end

@implementation CGameCardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck :(CGameDeck *)deck {
    
    self = [super init]; //Initializer designado de nuestro super
    
    if (self) {
        
        //Para que no
        self.status = @"";
        
        for (int i = 0; i < count; i++) {
            //Obtenemos una carta al azar
            CGameCard *card = [deck drawRandomCard];
            
            if (card) {
                //Si no es valor nulo, la agregamos
                [self.cards addObject:card];
            } else {
                //Si no, se regresa el inicializador como nulo porque no se puede iniciar sin cartas
                self = nil;
            }
            
        }
    }
    
    return self;
    
}

- (CGameCard *)cardAtIndex:(NSUInteger)index {
    return (index <[self.cards count]) ? self.cards[index] : nil;
}

//Definimos nuestras constantes a usar
static const int MISS_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    CGameCard *card = [self cardAtIndex:index]; //Creamos el objeto carta a usar del indice de nuestro mutable array.
    
    //Solo cartas que no esten con pareja pueden usarse
    if (!card.isMatched) {
        
        //Es de verificar si la carta a comparar ya esta seleccionada
        if (card.isChosen) {
            card.chosen = NO; //Si esta seleccionada, la de-seleccionamos
        } else {
            self.status = [NSString stringWithFormat:@"%@", card.contents];
            //Si no lo esta, procedemos a hacer la comparacion en el arreglo de todas las cartas para ver cuales estan sin pareja y seleccionadas
            for (CGameCard *otherCard in self.cards) {
                
                //Verificamos si nuestra otra carta esta seleccionada y no esta con pareja
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    //El metodo match de CGameCard recibe un arreglo, por lo que enviamos nuestra carta seleccionada en un arreglo
                    int matchScore = [card match:@[otherCard]];
                    
                    //Si existe un match en el metodo de "match" de CGameCard, nos regresaria un valor, por lo que comparamos el resultado
                    if (matchScore) {
                        int bonus = matchScore * MATCH_BONUS;
                        self.score += bonus;
                        
                        //Ya que son pareja, dejamos seleccionadas las cartas
                        card.matched = YES;
                        otherCard.matched = YES;
                        
                        self.status = [NSString stringWithFormat:@"Matched %@ %@ for %ld points!", card.contents, otherCard.contents, (long)bonus];
                        
                    } else {
                        self.score -= MISS_PENALTY;
                        
                        self.status = [NSString stringWithFormat:@"%@ %@ don't match! %ld score penalty!", card.contents, otherCard.contents, (long)MISS_PENALTY];
                        
                        //Si no parejan, la deseleccionamos (cuando sean 3 o mas no seria necesario desseleccionarla)
                        otherCard.chosen = NO;
                    }
                    break; //Debido a que por el momento solo seleccionamos 2 cartas
                    
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
    
}

@end
