//
//  ViewController.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/9/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "ViewController.h"
#import "CGameCard.h"
#import "CGameCardMatchingGame.h"
#import "CGameHistoryViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CGameCardMatchingGame *game;//Modelo de juego
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStatus;

@property (strong, nonatomic) NSMutableArray *history;

@end

@implementation ViewController

- (CGameCardMatchingGame *)game {
    if (!_game) _game = [[CGameCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    return _game;
}

- (NSMutableArray *)history {
    
    if (!_history) _history = [[NSMutableArray alloc] init];
    
    return _history;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[CGameHistoryViewController class]]) {
            
            CGameHistoryViewController *hvc = (CGameHistoryViewController *)segue.destinationViewController;
            hvc.history = self.history;
            
        }
    }
    
}

//Abstract method
- (CGameDeck *)createDeck {
    return nil;
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
    
    [self.history addObject:self.game.status];
    
}

- (NSString *)setTitleForCard:(CGameCard *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)setBackgroundImage:(CGameCard *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
