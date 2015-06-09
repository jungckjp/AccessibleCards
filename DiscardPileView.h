//
//  DiscardPileView.h
//  AccessibleCards
//
//  Created by Jonathan Jungck on 5/12/15.
//  Copyright (c) 2015 Jonathan Jungck. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

@interface DiscardPileView : UIView
@property (nonatomic, strong) NSMutableArray * discardPile;



- (void)discardCard:(CardRank)rank suit:(CardSuit)suit;
- (CardView *)getLast;

@end
