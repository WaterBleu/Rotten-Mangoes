//
//  Review.h
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic) NSString* critic;
@property (nonatomic) NSString* date;
@property (nonatomic) NSString* freshness;
@property (nonatomic) NSString* publication;
@property (nonatomic) NSString* quote;

- (instancetype)initWithCritic:(NSString*)critic andDate:(NSString*)date andFreshness:(NSString*)freshness andPublication:(NSString*)publication andQuote:(NSString*)quote;

@end
