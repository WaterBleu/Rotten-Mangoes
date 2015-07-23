//
//  Movie.m
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface Movie ()

@end

@implementation Movie

- (instancetype)initWithID:(NSString*)movieID Poster:(NSURL*)posterURL andTitle:(NSString*)title andRunTime:(NSNumber*)runtime andmpaaRating:(NSString*)mpaa_rating
{
    self = [super init];
    if (self) {
        self.movieID = movieID;
        self.posterURL = posterURL;
        self.title = title;
        self.runtime = runtime;
        self.mpaa_rating = mpaa_rating;
    }
    return self;
}

- (UIImage*) getPosterImg{
    if(!self.posterImg){
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.posterURL];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error){
                self.posterImg = [UIImage imageWithData:data];
            }
        }];
        
        [dataTask resume];
    }
    return self.posterImg;
}

- (void)setImage:(NSURL*)posterURL{
    
}

@end
