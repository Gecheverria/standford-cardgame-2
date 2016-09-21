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
            //Para guardar nuestras cartas seleccionadas para el match 3
            NSMutableArray *currentSelectedCards = [[NSMutableArray alloc] init];
            
            switch ((unsigned long)self.matchType) {
                //2 cartas, codigo ya existente.
                case 0:
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
                    
                    break;
                    
                case 1:
                    
                    self.status = [NSString stringWithFormat:@"Selected %@", card.contents];

                    
                    for (CGameCard *otherCard in self.cards) {
                        
                        //Llenamos nuestro arreglo de cartas seleccionadas
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            
                            [currentSelectedCards addObject:otherCard];
                            
                        }
                        
                        //Cuando se tengan 2 cartas adicionales seleccionadas para comparar, entramos al if
                        if ([currentSelectedCards count] == 2) {

                            CGameCard *cardTwo = [currentSelectedCards objectAtIndex:0];
                            CGameCard *cardThree = [currentSelectedCards objectAtIndex:1];
                            
                            int matchScore =[card match:currentSelectedCards];
                            
                            if (matchScore) {
                                
                                int bonus = matchScore * MATCH_BONUS;
                                self.score += bonus;
                                
                                //Seteamos las 2 cartas como matched
                                for (CGameCard *otherCard in currentSelectedCards) {
                                    otherCard.matched = YES;
                                    
                                }
                                
                                card.matched = YES;
                                self.status = [NSString stringWithFormat:@"Match found in %@ %@ %@ for %ld points!", card.contents, cardTwo.contents, cardThree.contents , (long)bonus];
                                
                                
                            } else {
                                
                                self.score -= MISS_PENALTY;
                                
                                for (CGameCard *otherCard in currentSelectedCards) {
                                    otherCard.chosen = NO;
                                    
                                }
                                
                                self.status = [NSString stringWithFormat:@"%@ %@ and %@ doesn't match! %ld score penalty!", card.contents, cardTwo.contents, cardThree.contents, (long)MISS_PENALTY];
                                
                            }
                            
                        }
                    }
                    
                    self.score -= COST_TO_CHOOSE;
                    card.chosen = YES;
                    
                    break;
                    
                default:
                    NSLog(@"How did you get here?");
                    break;
            }
        }
    }
}

@end
