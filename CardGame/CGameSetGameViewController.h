//
//  CGameSetGameViewController.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CGameSetCard.h"

@interface CGameSetGameViewController : ViewController

- (NSMutableAttributedString *)contentFormatting:(CGameSetCard *)card;

@end
