//
//  CardView.m
//  AccessibleCards
//
//  Created by Jonathan Jungck on 5/12/15.
//  Copyright (c) 2015 Tim Ekl and Jonathan Jungck. All rights reserved.
//

#import "CardView.h"

@interface CardView ()



@end

@implementation CardView

+ (NSArray *)shuffledDeck;
{
    NSMutableArray *sortedCards = [NSMutableArray arrayWithCapacity:52];
    for (CardSuit suit = CardSuitClubs; suit <= CardSuitSpades; suit++) {
        for (CardRank rank = CardRankAce; rank <= CardRankKing; rank++) {
            [sortedCards addObject:[[CardView alloc] initWithRank:rank suit:suit]];
        }
    }
    
    // Do the shuffle (Fisher-Yates, that is)
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[sortedCards count]];
    for (NSUInteger i = 0; i < [sortedCards count]; i++) {
        NSUInteger j = arc4random_uniform((uint32_t)i);
        if (j != i) {
            result[i] = result[j];
        }
        result[j] = sortedCards[i];
    }
    
    return result;
}


#pragma mark - API

- (id)initWithRank:(CardRank)rank suit:(CardSuit)suit;
{
    // Pick some arbitrary non-zero-size frame
    if (!(self = [super initWithFrame:CGRectMake(0, 0, 50, 100)])) {
        return nil;
    }
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 2;
    self.layer.cornerRadius = 10;
    
    _rankLabel = [[UILabel alloc] init];
    _suitLabel = [[UILabel alloc] init];
    
    for (UILabel *label in @[ _rankLabel, _suitLabel ]) {
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rankLabel, _suitLabel);
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_rankLabel]-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_suitLabel]-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_rankLabel]-[_suitLabel]-|"
                                                                                    options:0
                                                                                    metrics:nil
                                                                                      views:views]];
    [NSLayoutConstraint constraintWithItem:_rankLabel
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_suitLabel
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    // Use setters here so the labels are updated
    self.rank = rank;
    self.suit = suit;
    
    // Set touch selector
    
    
    return self;
}

- (void) lastCardRemove {
    self.rankLabel.text = @"";
    self.suitLabel.text = @"";
}

#pragma mark - UIAccessibilityElement

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSString *) accessibilityLabel {
    NSString * cardString;
    
    // Rank
    if ([self.rankLabel.text isEqualToString:@"A"]) {
        cardString = @"Ace";
    } else if ([self.rankLabel.text isEqualToString:@"K"]){
        cardString = @"King";
    } else if ([self.rankLabel.text isEqualToString:@"Q"]){
        cardString = @"Queen";
    } else if ([self.rankLabel.text isEqualToString:@"J"]){
        cardString = @"Jack";
    } else if ([self.rankLabel.text isEqualToString:@""]) {
        return NSLocalizedString(@"Empty Deck", nil);
    }else {
        cardString = self.rankLabel.text;
    }
    
    cardString = NSLocalizedString(cardString, nil);
    cardString = [cardString stringByAppendingString:NSLocalizedString(@" of ", ni)];
    
    // Suit
    if ([self.suitLabel.text  isEqual: @"♣"]) {
        cardString = [cardString stringByAppendingString:NSLocalizedString(@"Clubs", nil)];
    } else if ([self.suitLabel.text isEqualToString:@"♦"]) {
        cardString = [cardString stringByAppendingString:NSLocalizedString(@"Diamonds", nil)];
    } else if ([self.suitLabel.text isEqualToString:@"♥"]) {
        cardString = [cardString stringByAppendingString:NSLocalizedString(@"Hearts", nil)];
    } else {
        cardString = [cardString stringByAppendingString:NSLocalizedString(@"Spades", nil)];
    }
    
    return cardString;
}

#pragma mark Custom accessors

- (void)setRank:(CardRank)rank;
{
    _rank = rank;
    
    switch (rank) {
        case CardRankJack: self.rankLabel.text = @"J"; break;
        case CardRankQueen: self.rankLabel.text = @"Q"; break;
        case CardRankKing: self.rankLabel.text = @"K"; break;
        case CardRankAce: self.rankLabel.text = @"A"; break;
        default: self.rankLabel.text = [@(rank + 1) stringValue]; break;
    }
}

- (void)setSuit:(CardSuit)suit;
{
    _suit = suit;
    
    switch (suit) {
        case CardSuitClubs: self.suitLabel.text = @"♣"; break;
        case CardSuitDiamonds: self.suitLabel.text = @"♦"; break;
        case CardSuitHearts: self.suitLabel.text = @"♥"; break;
        case CardSuitSpades: self.suitLabel.text = @"♠"; break;
    }
    
    if (suit == CardSuitSpades || suit == CardSuitClubs) {
        self.rankLabel.textColor = self.suitLabel.textColor = [UIColor blackColor];
    } else {
        self.rankLabel.textColor = self.suitLabel.textColor = [UIColor redColor];
    }
}

@end
