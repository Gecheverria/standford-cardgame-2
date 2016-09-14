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
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentSwitchGameType;

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
    
    //creamos un nuevo deck
    self.game = [[CGameCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    //Habilitamos el segmented control
    self.segmentSwitchGameType.userInteractionEnabled = YES;
    self.segmentSwitchGameType.tintColor = [UIColor colorWithRed:122.0f/255.0f
                                                           green:0.0f/255.0f
                                                            blue:0.0f/255.0f
                                                           alpha:1.0f];
    
    //Actualizamos el UI
    [self updateUI];
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    //Desactivamos el segmented control
    self.segmentSwitchGameType.userInteractionEnabled = NO;
    self.segmentSwitchGameType.tintColor = [UIColor grayColor];
    
    //Creamos una variable para obtener el indice del boton mediante el sender
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    
    //A nuestro game de esta clase le pasamos el indice al metodo chooseCardAtIndex con la variable anterior
    [self.game chooseCardAtIndex:chosenButtonIndex];
    //Debemos actualiar el UI con un metodo que creamos
    [self updateUI];
}

-(void)updateUI {
    
    //Actualizaremos la interfaz recorriendo todos los cardButtons y en base a nuestra CGameCard en nuestro modelo le pondremos el titulo y el fondo de imagen a cada carta
    for (UIButton *cardButton in self.cardButtons) {
        
        //Obtenemos el indice del boton actual
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
        
        //Creamos una carta para obtener sus propiedades
        CGameCard *card = [self.game cardAtIndex:cardButtonIndex];
        
        //Luego ponemos los datos del objeto a la carta
        [cardButton setTitle:[self setTitleForCard:card] forState:UIControlStateNormal];
        
        [cardButton setBackgroundImage:[self setBackgroundImage:card] forState:UIControlStateNormal];
        
        //Si la carta encontro pareja, hay que deshabilitarla
        cardButton.enabled = !card.isMatched;
        
        //Actualizamos la puntuacion
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        
    }
    
}

- (NSString *)setTitleForCard:(CGameCard *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)setBackgroundImage:(CGameCard *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
