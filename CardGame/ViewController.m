//
//  ViewController.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/9/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "ViewController.h"
#import "CGamePlayingCardDeck.h"
#import "CGameCard.h"
#import "CGameCardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CGameCardMatchingGame *game;//Modelo de juego
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStatus;

@end

@implementation ViewController

- (CGameCardMatchingGame *)game {
    if (!_game) _game = [[CGameCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    return _game;
}

- (CGameDeck *)createDeck {
    return [[CGamePlayingCardDeck alloc] init];
}


- (IBAction)generateNewDeckButton:(UIButton *)sender {

    self.game = nil;
    
    [self updateUI];
    
}


- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
}

-(void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {

        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
 
        CGameCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self setTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImage:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.gameStatus.text = [NSString stringWithFormat:@"%@", self.game.status];
        
    }
    
}

- (NSString *)setTitleForCard:(CGameCard *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)setBackgroundImage:(CGameCard *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
