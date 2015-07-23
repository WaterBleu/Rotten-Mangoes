//
//  Review.m
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "Review.h"



@implementation Review

- (instancetype)initWithCritic:(NSString*)critic andDate:(NSString*)date andFreshness:(NSString*)freshness andPublication:(NSString*)publication andQuote:(NSString*)quote
{
    self = [super init];
    if (self) {
        self.critic = critic;
        self.date = date;
        self.freshness = freshness;
        self.publication = publication;
        self.quote = quote;
    }
    return self;
}

@end
