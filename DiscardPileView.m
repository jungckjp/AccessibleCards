//
//  DiscardPileView.m
//  AccessibleCards
//
//  Created by Jonathan Jungck on 5/12/15.
//  Copyright (c) 2015 Jonathan Jungck. All rights reserved.
//

#import "DiscardPileView.h"

@implementation DiscardPileView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init {
    self = [super init];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 2;
    self.layer.cornerRadius = 10;
    if (self) {
        self.discardPile = [NSMutableArray arrayWithCapacity:52];
    }
    return self;
}

- (void)discardCard:(CardRank)rank suit:(CardSuit)suit {
    [self.discardPile addObject:[[CardView alloc] initWithRank:rank suit:suit]];
}

- (CardView *) getLast {
    if ([self.discardPile count] == 0) {
        return nil;
    }
    return (CardView *)[self.discardPile lastObject];
}

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSString *) accessibilityLabel {
    CardView * last = [self getLast];
    if (last != nil) {
        NSString * cardString;
        
        // Rank
        if ([last.rankLabel.text isEqualToString:@"A"]) {
            cardString = @"Ace";
        } else if ([last.rankLabel.text isEqualToString:@"K"]){
            cardString = @"King";
        } else if ([last.rankLabel.text isEqualToString:@"Q"]){
            cardString = @"Queen";
        } else if ([last.rankLabel.text isEqualToString:@"J"]){
            cardString = @"Jack";
        } else {
            cardString = last.rankLabel.text;
        }
        
        cardString = NSLocalizedString(cardString, nil);
        cardString = [cardString stringByAppendingString:NSLocalizedString(@" of ", ni)];
        
        // Suit
        if ([last.suitLabel.text  isEqual: @"♣"]) {
            cardString = [cardString stringByAppendingString:NSLocalizedString(@"Clubs", nil)];
        } else if ([last.suitLabel.text isEqualToString:@"♦"]) {
            cardString = [cardString stringByAppendingString:NSLocalizedString(@"Diamonds", nil)];
        } else if ([last.suitLabel.text isEqualToString:@"♥"]) {
            cardString = [cardString stringByAppendingString:NSLocalizedString(@"Hearts", nil)];
        } else {
            cardString = [cardString stringByAppendingString:NSLocalizedString(@"Spades", nil)];
        }
        
        return cardString;
    }
    
    return NSLocalizedString(@"Discard Pile", nil);
}


@end
