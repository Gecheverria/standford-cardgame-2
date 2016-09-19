//
//  CGameSetMatchingGame.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGameDeck.h"
#import "CGameCard.h"

@interface CGameSetMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGameDeck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (CGameCard *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *status;

@end
