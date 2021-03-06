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
@property (strong, nonatomic) NSMutableArray *history;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *score;

@end

@implementation CGameSetGameViewController

#pragma mark - Lazy instantiation

- (NSMutableArray *)history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (CGameSetMatchingGame *)game {
    if (!_game) _game = [[CGameSetMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (CGameDeck *)createDeck {
    return [[CGameSetCardDeck alloc] init];
}

#pragma mark - View stuff

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (IBAction)newDeck:(UIButton *)sender {
    self.game = nil;
    self.status.text = @"";
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[CGameHistoryViewController class]]) {
            
            CGameHistoryViewController *hvc = (CGameHistoryViewController *)segue.destinationViewController;
            hvc.history = self.history;
        }
    }
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
        CGameSetCard *card = [self.game cardAtIndex:cardButtonIndex];
        
        NSMutableAttributedString *cardContent = [self contentFormatting:card];
        [cardButton setAttributedTitle:cardContent forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImage:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
        if ([card.contents isEqualToString:self.game.status]) {
            NSMutableAttributedString *label = [self contentFormatting:card];
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"Selected "];
            [attrStr appendAttributedString:label];

            
            self.status.attributedText = attrStr;
            
            [self.history addObject:attrStr];
        }

        self.score.text = [NSString stringWithFormat:@"Matches: %ld", (long)self.game.score];
    }
}

#pragma mark - Styles Method

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
