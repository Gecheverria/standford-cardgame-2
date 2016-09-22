//
//  CGamePlayingCardGameViewController.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/21/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGamePlayingCardGameViewController.h"
#import "CGamePlayingCardDeck.h"

@implementation CGamePlayingCardGameViewController

- (CGameDeck *)createDeck {
    return [[CGamePlayingCardDeck alloc] init];
}

@end
