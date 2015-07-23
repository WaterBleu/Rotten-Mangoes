//
//  ReviewTable.m
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "ReviewTable.h"
#import "ReviewCell.h"
#import "Review.h"

@interface ReviewTable () 

@property (nonatomic) NSMutableArray* objects;

@end

@implementation ReviewTable

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
    Review *currentReview = self.objects[indexPath.row];
    
    cell.labelCritic.text = currentReview.critic;
    cell.labelDate.text = currentReview.date;
    cell.labelFreshness.text = currentReview.freshness;
    cell.labelPublication.text = currentReview.publication;
    cell.labelQuote.text = currentReview.quote;
    return cell;
}

@end
