//
//  CGameSetCard.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameCard.h"

@interface CGameSetCard : CGameCard

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *)symbolStrings;
+ (NSArray *)colors;
+ (NSArray *)numbers;
+ (NSArray *)shading;

@end
