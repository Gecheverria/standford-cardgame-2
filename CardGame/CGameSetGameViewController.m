//
//  CGameSetGameViewController.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/19/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameSetGameViewController.h"
#import "CGameSetMatchingGame.h"
#import "CGameSetCardDeck.h"

@interface CGameSetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setCardButtons;

@property (strong, nonatomic) CGameSetMatchingGame *game; //Model

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *score;


@end

@implementation CGameSetGameViewController

- (CGameSetMatchingGame *)game {
    if (!_game) _game = [[CGameSetMatchingGame alloc] initWithCardCount:[self.setCardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (CGameDeck *)createDeck {
    return [[CGameSetCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = (int)[self.setCardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
    
}


- (IBAction)newDeck:(UIButton *)sender {
    
    self.game = nil;
    
    [self updateUI];
    
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.setCardButtons) {
        
        int cardButtonIndex = (int)[self.setCardButtons indexOfObject:cardButton];
        
        CGameCard *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[card contents] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImage:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
        
        self.score.text = [NSString stringWithFormat:@"Matches: %ld", (long)self.game.score];
        
        
    }
    
}

- (UIImage *)setBackgroundImage:(CGameCard *)card {
    return [UIImage imageNamed:card.isChosen ? @"selCardFront" : @"cardfront"];
}

@end
