//
//  CGameSetMatchingGame.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameSetMatchingGame.h"

@interface CGameSetMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *status;
@property (strong, nonatomic) NSMutableArray *setCards; //of CGameCard (casted to CGameSetCard in Controller)

@end

@implementation CGameSetMatchingGame

- (NSMutableArray *)setCards {
    if (!_setCards) _setCards = [[NSMutableArray alloc] init];
    return _setCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGameDeck *)deck {
    
    self = [super init];
    
    if (self) {
        
        self.status = @"";
        
        for (int i = 0; i < count; i++) {
            
            CGameCard *card = [deck drawRandomCard];
            
            if (card) {
                [self.setCards addObject:card];
            } else {
                self = nil;
            }
        }
    }
    
    return self;
}

- (CGameSetCard *)cardAtIndex:(NSUInteger)index {
    return (index <[self.setCards count]) ? self.setCards[index] : nil;
}

static const int SET_SCORE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    
    CGameSetCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
            
            self.status = [NSString stringWithFormat:@"%@", card.contents];
            
            for (CGameSetCard *otherCard in self.setCards) {
                
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [selectedCards addObject:otherCard];
                }
                
                if ([selectedCards count] == 2) {
                    
                    int matchScore = [card match:selectedCards];
                    
                    if (matchScore) {
                        
                        self.score += SET_SCORE;
                        
                        card.matched = YES;
                        
                        for (CGameSetCard *otherCard in selectedCards) {
                            otherCard.matched = YES;
                        }
                        
                        self.status = [NSString stringWithFormat:@"Match found!"];
                        
                    } else {
                        
                        for (CGameSetCard *otherCard in selectedCards) {
                            otherCard.chosen = NO;
                        }
                        
                        self.status = [NSString stringWithFormat:@"NO MATCH 4 U!"];
                        
                    }
                    
                }
            }
            
            card.chosen = YES;
            
        }
    }
    
}

@end
