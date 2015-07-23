//
//  ReviewCell.h
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelCritic;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelFreshness;
@property (weak, nonatomic) IBOutlet UILabel *labelPublication;
@property (weak, nonatomic) IBOutlet UILabel *labelQuote;



@end
