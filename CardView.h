//
//  CardView.h
//  AccessibleCards
//
//  Created by Tim Ekl on 2/7/15.
//  Edited by Jonathan Jungck on 5/12/15.
//  Copyright (c) 2015 Tim Ekl and Jonathan Jungck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CardSuit) {
    CardSuitClubs,
    CardSuitDiamonds,
    CardSuitHearts,
    CardSuitSpades,
};

typedef NS_ENUM(NSUInteger, CardRank) {
    CardRankAce,
    CardRankTwo,
    CardRankThree,
    CardRankFour,
    CardRankFive,
    CardRankSix,
    CardRankSeven,
    CardRankEight,
    CardRankNine,
    CardRankTen,
    CardRankJack,
    CardRankQueen,
    CardRankKing,
};

@interface CardView : UIView

@property (nonatomic, assign) CardRank rank;
@property (nonatomic, assign) CardSuit suit;

@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UILabel *suitLabel;

+ (NSArray *)shuffledDeck;

- (id)initWithRank:(CardRank)rank suit:(CardSuit)suit;
- (void) lastCardRemove;

@end
