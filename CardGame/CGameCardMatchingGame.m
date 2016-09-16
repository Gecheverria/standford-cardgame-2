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

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck :(CGameDeck *)deck gameType:(NSUInteger)type {
    
    self = [super init];
    
    if (self) {
        
        //Definimos que valor tendra matchType para ver como se jugara
        self.matchType = type;
        
        //Para que no salga (nil) en el satus label cuando creamos un nuevo deck
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
                //2 cards
                case 0:
                    self.status = [NSString stringWithFormat:@"%@", card.contents];
                    
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
                    
                    self.status = [NSString stringWithFormat:@"%@", card.contents];
                    
                    for (CGameCard *otherCard in self.cards) {
                        
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            
                            [currentSelectedCards addObject:otherCard];
                            
                        }
                        
                        if ([currentSelectedCards count] == 2) {
                            
                            int matchScore =[card match:currentSelectedCards];
                            
                            if (matchScore) {
                                
                                self.score = matchScore * MATCH_BONUS;
                                
                                for (CGameCard *otherCard in currentSelectedCards) {
                                    otherCard.matched = YES;
                                }
                                
                                card.matched = YES;
                                
                            } else {
                                
                                self.score -= MISS_PENALTY;
                                
                                for (CGameCard *otherCard in currentSelectedCards) {
                                    otherCard.chosen = NO;
                                }
                                
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
