//
//  CGamePlayingCard.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/12/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameCard.h"

@interface CGamePlayingCard : CGameCard

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRanks;

@end
