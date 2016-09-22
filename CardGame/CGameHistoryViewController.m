//
//  CGameHistoryViewController.m
//  CardGame
//
//  Created by Gabriel Enrique Echeverria Mira on 9/21/16.
//  Copyright © 2016 Gabriel Enrique Echeverria Mira. All rights reserved.
//

#import "CGameHistoryViewController.h"

@interface CGameHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textViewHistory;

@end

@implementation CGameHistoryViewController

- (void)showHistory:(NSArray *)history {
    
    _history = history;
    if (self.view.window)[self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    
    NSMutableAttributedString *attrstr = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *status in self.history) {
        [attrstr appendAttributedString:status];
        [attrstr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    self.textViewHistory.attributedText = attrstr;
}

@end
