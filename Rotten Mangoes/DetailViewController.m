//
//  DetailViewController.m
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "DetailViewController.h"
#import "Movie.h"
#import "Review.h"
#import "ReviewCell.h"
#import "ReviewTable.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelRuntime;
@property (weak, nonatomic) IBOutlet UILabel *labelRated;
@property (weak, nonatomic) IBOutlet UIImageView *imagePoster;
@property (weak, nonatomic) IBOutlet ReviewTable *reviewTable;
@property (weak, nonatomic) IBOutlet ReviewCell *reviewCell;


@property (nonatomic) NSMutableArray* objects;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self setReview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (void)setReview{
    if (self.detailItem){
        Movie *currentMovie = self.detailItem;
        NSString *movieID = currentMovie.movieID;
        
        NSString *apiKey = @"55gey28y6ygcr8fjy4ty87ek";
        NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/reviews.json?apikey=%@&page_limit=3", movieID, apiKey]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:targetURL];
        NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error){
                NSError *jsonError = nil;
                
                NSDictionary *retrievedReviewDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                NSArray *retrievedReviewList = retrievedReviewDict[@"reviews"];
                NSMutableArray *reviewArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary *review in retrievedReviewList){
                    NSString *critic = review[@"critic"];
                    NSString *date = review[@"date"];
                    NSString *freshness = review[@"freshness"];
                    NSString *publication = review[@"publication"];
                    NSString *quote = review[@"quote"];
                    
                    Review *r = [[Review alloc] initWithCritic:critic andDate:date andFreshness:freshness andPublication:publication andQuote:quote];
                    [reviewArray addObject:r];
                }
                self.objects = reviewArray;
              //  [self.reviewTable reloadData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.reviewTable reloadData];
                });
            }
        }];
        [dataTask resume];

    }
}

#pragma mark - UITableView function
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
