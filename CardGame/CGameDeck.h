//
//  CGameDeck.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGameCard.h"

@interface CGameDeck : NSObject

- (void)addCard:(CGameCard *)card atTop:(BOOL)atTop;
- (void)addCard:(CGameCard *)card;

- (CGameCard *)drawRandomCard;


@end
