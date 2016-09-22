//
//  ViewController.h
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/9/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGameDeck.h"

@interface ViewController : UIViewController

-(CGameDeck *)createDeck; //Abstract

@end

