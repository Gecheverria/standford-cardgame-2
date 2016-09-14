//
//  CGameCardMatchingGame.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGameDeck.h"
#import "CGameCard.h"

@interface CGameCardMatchingGame : NSObject

//Initializer designado
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CGameDeck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (CGameCard *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *status;

@end
