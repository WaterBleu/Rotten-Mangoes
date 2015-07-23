//
//  Movie.h
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

- (instancetype)initWithID:(NSString*)movieID Poster:(NSURL*)posterURL andTitle:(NSString*)title andRunTime:(NSNumber*)runtime andmpaaRating:(NSString*)mpaa_rating;

@property (nonatomic) NSString* movieID;
@property (nonatomic) NSString* title;
@property (nonatomic) NSNumber* runtime;
@property (nonatomic) NSString* mpaa_rating;
@property (nonatomic) NSURL* posterURL;
@property (nonatomic) UIImage* posterImg;

- (UIImage*) getPosterImg;

@end
