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
@property (strong, nonatomic) NSMutableArray *setCards; //of CGameCard

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

- (CGameCard *)cardAtIndex:(NSUInteger)index {
    return (index <[self.setCards count]) ? self.setCards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    
}

@end
