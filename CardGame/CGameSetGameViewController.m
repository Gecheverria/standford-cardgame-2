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
#import "CGameSetCard.h"

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
        
        //Casting used to access CGameSetCard contents, otherwise, dissection of method "contents" would need to be done
        CGameSetCard *card = (CGameSetCard *)[self.game cardAtIndex:cardButtonIndex];
        
        NSMutableAttributedString *cardContent = [self contentFormatting:card];
        
        [cardButton setAttributedTitle:cardContent forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImage:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
        
        self.score.text = [NSString stringWithFormat:@"Matches: %ld", (long)self.game.score];
        
        
    }
    
}

- (NSMutableAttributedString *)contentFormatting:(CGameSetCard *)card {
    
    NSString *body = [[NSString alloc] init];
    
    for (int i = 0; i < card.number; i++) {
        body = [NSString stringWithFormat:@"%@ %@", body, card.symbol];
    }
    
    UIColor *colorToUse = [UIColor blackColor];
    if ([card.color isEqualToString:@"red"]) colorToUse = [UIColor redColor];
    if ([card.color isEqualToString:@"green"]) colorToUse = [UIColor greenColor];
    if ([card.color isEqualToString:@"blue"]) colorToUse = [UIColor blueColor];
    
    double alpha = 0.5;
    if ([card.shading isEqualToString:@"solid"]) alpha = 1.0;
    if ([card.shading isEqualToString:@"outline"]) alpha = 0.0;
    if ([card.shading isEqualToString:@"alpha"]) alpha = 0.3;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:body];
    
    NSDictionary *attr = @{
                           NSForegroundColorAttributeName : [colorToUse colorWithAlphaComponent:alpha],
                           NSStrokeWidthAttributeName : @-5,
                           NSStrokeColorAttributeName : colorToUse
                           };
    
    NSRange range = NSMakeRange(0, attrStr.length);
    
    [attrStr setAttributes:attr range:range];
    
    return attrStr;
    
}

- (UIImage *)setBackgroundImage:(CGameCard *)card {
    return [UIImage imageNamed:card.isChosen ? @"selCardFront" : @"cardfront"];
}


@end
