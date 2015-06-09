//
//  ViewController.m
//  HW_AccessibleCards_jungckjp
//
//  Created by Jonathan Jungck on 5/12/15.
//  Copyright (c) 2015 Jonathan Jungck. All rights reserved.
//

#import "ViewController.h"
#import "DiscardPileView.h"
#import "CardView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet DiscardPileView *discardPile;
@property (strong, nonatomic) IBOutlet CardView *cardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self resetDeck];
    UITapGestureRecognizer *cardViewTap = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *discardViewTap = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleSingleTap:)];
    self.discardPile = [self.discardPile init];
    [self.discardPile addGestureRecognizer:discardViewTap];
    [self.cardView addGestureRecognizer:cardViewTap];
}

- (void) resetDeck {
    self.deck = (NSMutableArray *)[CardView shuffledDeck];
    self.discardPile.discardPile = [NSMutableArray new];
    if ([self.deck count] != 0) {
        CardView * card = [self.deck lastObject];
        [self.deck removeLastObject];
        self.cardView = [self.cardView initWithRank:card.rank suit:card.suit];
        self.cardView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.cardView) {
        [self.discardPile discardCard:self.cardView.rank suit:self.cardView.suit];
        if ([self.deck count] == 0) {
            // First time set as card back, afterwards do minimal effort,
            // as opposed to removing the tap recognizer each time.
            self.cardView.backgroundColor = [UIColor lightGrayColor];
            [self.cardView lastCardRemove];
        } else {
            CardView * card = [self.deck lastObject];
            [self.cardView setRank:card.rank];
            [self.cardView setSuit:card.suit];
            [self.deck removeLastObject];
        }
    } else {
        [self.cardView lastCardRemove];
        [self resetDeck];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end