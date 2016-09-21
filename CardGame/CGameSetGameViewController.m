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
#import "CGameHistoryViewController.h"

@interface CGameSetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CGameSetMatchingGame *game; //Model

@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *score;


@end

@implementation CGameSetGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[CGameHistoryViewController class]]) {
            
            CGameHistoryViewController *hvc = (CGameHistoryViewController *)segue.destinationViewController;
            hvc.history = @[@"Hello", @"From", @"Set!"];
            
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (CGameSetMatchingGame *)game {
    if (!_game) _game = [[CGameSetMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (CGameDeck *)createDeck {
    return [[CGameSetCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    [self updateUI];
    
}


- (IBAction)newDeck:(UIButton *)sender {
    
    self.game = nil;
    
    [self updateUI];
    
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];

        CGameSetCard *card = [self.game cardAtIndex:cardButtonIndex];
        
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
