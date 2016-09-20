//
//  CGameSetGameViewController.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGameSetCard.h"

@interface CGameSetGameViewController : UIViewController

- (NSMutableAttributedString *)contentFormatting:(CGameSetCard *)card;

@end
