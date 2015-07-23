//
//  DetailViewController.m
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "DetailViewController.h"
#import "Movie.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelRuntime;
@property (weak, nonatomic) IBOutlet UILabel *labelRated;
@property (weak, nonatomic) IBOutlet UIImageView *imagePoster;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Movie *currentMovie = self.detailItem;
        self.labelTitle.text = currentMovie.title;
        self.labelRuntime.text = [NSString stringWithFormat:@"%@ Minutes",currentMovie.runtime];
        self.labelRated.text = currentMovie.mpaa_rating;
        self.imagePoster.image = currentMovie.posterImg;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
