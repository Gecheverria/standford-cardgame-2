//
//  CGameCard.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameCard.h"

@interface CGameCard();

@end

@implementation CGameCard

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    for (CGameCard *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
    
}

@end
