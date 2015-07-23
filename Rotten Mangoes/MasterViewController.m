//
//  CollectionViewController.m
//  Rotten Mangoes
//
//  Created by Jeff Huang on 2015-07-22.
//  Copyright (c) 2015 Jeff Huang. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Movie.h"
#import "MovieCell.h"

@interface MasterViewController ()

@property (nonatomic) NSMutableArray* object;

@end

@implementation MasterViewController

static NSString * const reuseIdentifier = @"movieCell";
static NSString * const imgIdentifier = @"dkpu1ddg7pbsk.cloudfront.net";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    NSString *mainURL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=";
    NSString *apiKey = @"55gey28y6ygcr8fjy4ty87ek";
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", mainURL, apiKey]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:targetURL];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error){
            NSError *jsonError = nil;
            
            NSDictionary *retrievedMovieDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSArray *retrievedMovieList = retrievedMovieDict[@"movies"];
            NSMutableArray *movieArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *movie in retrievedMovieList){
                NSString *title = movie[@"title"];
                NSNumber *runtime = movie[@"runtime"];
                NSString *mpaa_rating = movie[@"mpaa_rating"];
                NSString *fullURL = [movie valueForKeyPath:@"posters.profile"];
                NSRange range = NSMakeRange([fullURL rangeOfString:imgIdentifier].location, fullURL.length-1);
                NSString *suffixURL = [fullURL substringFromIndex:range.location];
                NSURL *posterURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", suffixURL]];
                Movie *m = [[Movie alloc] initWithPoster:posterURL andTitle:title andRunTime:runtime andmpaaRating:mpaa_rating];
                [movieArray addObject:m];
            }
            self.object = movieArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.object.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Movie *currentMovie = self.object[indexPath.row];
    // Configure the cell
    cell.imageView.image = [currentMovie getPosterImg];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
        Movie *object = self.object[indexPath.item];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
