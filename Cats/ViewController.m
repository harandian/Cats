//
//  ViewController.m
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Hirad Harandian. All rights reserved.
//

#import "ViewController.h"
#import "Flickr.h"
#import "FlickrCollectionViewCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "ShowAllViewController.h"

@interface ViewController () <UICollectionViewDataSource, setLocation>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *flickrArray;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *tags;
@property BOOL isNew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNew = NO;
    [self URLSetup];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - URL Request Info
- (void)URLSetup
{
    
    NSURL *url = [NSURL new];
    
    if (self.isNew == NO) {
    
        url = [NSURL URLWithString: @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=54343404f4d0cec33556c0d1ffb4164a&has_geo=1&extras=url_m%2C+geo&format=json&nojsoncallback=1"];
    }
    
    if (self.isNew == YES) {
        
        NSString *tagReplace = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=54343404f4d0cec33556c0d1ffb4164a&has_geo=1&extras=url_m%%2C+geo&format=json&nojsoncallback=1%@%@";
        
        tagReplace = [NSString stringWithFormat:tagReplace, self.tags, self.location];
       // tagReplace = [tagReplace stringByReplacingOccurrencesOfString:@"&tags=cat" withString:self.tags];
        
        
        
        
        url = [NSURL URLWithString: tagReplace];
        
        NSLog(@"%@", url);
    }
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSError *jsonError = nil;
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSDictionary *photoDictionary = jsonDictionary[@"photos"];
            NSMutableArray *photoArray = photoDictionary[@"photo"];
            
            self.flickrArray = [NSMutableArray array];

            for (NSDictionary *flickr in photoArray)
            {
                Flickr * image = [[Flickr alloc] initWithDictionary:flickr];
                [self.flickrArray addObject:image];

            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
        }
    }];
    [dataTask resume];
    
    
}

#pragma mark - Flickr Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.flickrArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    Flickr *repo = self.flickrArray[indexPath.item];
    
    cell.flickrLabel.text = [repo title];
    cell.flickrLabel.lineBreakMode = NSLineBreakByWordWrapping; // Word wraps title into the label

    NSURL *imageURL = [repo imageURL];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:imageURL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *someImage = [UIImage imageWithData:data];
            cell.flickrImage.image = someImage;
        }];
    }];
    
    [dataTask resume];
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    
    if ([segue.identifier isEqual: @"detail"]) {
        DetailViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems].firstObject;
        Flickr *photoToShow = self.flickrArray[indexPath.item];
        detailViewController.photoToShow = photoToShow;
    }
    
    if ([segue.identifier isEqual: @"search"]) {
        SearchViewController *searchViewController = [segue destinationViewController];
        [searchViewController setDelegate:self];
        
    }
    
    if ([segue.identifier isEqual:@"showAll"]) {
        
        ShowAllViewController *showAllViewController = [segue destinationViewController];
        
        showAllViewController.pinArray = [NSArray arrayWithArray:self.flickrArray];
    }
    
}

- (void)sendData:(CLLocationCoordinate2D)currentLocation {
    
    double lon = currentLocation.longitude;
    double lat = currentLocation.latitude;
    
    NSLog(@"this is long %.2f, the lat is %.2f",lon,lat);
    
    self.location = [NSString new];
    self.location = [NSString stringWithFormat:@"&lat=%f&lon=%f",lat,lon];
    NSLog(@"%@",self.location);
    
}

- (void)sendTags:(NSString *)tags {
    
    if (tags == nil) {
    
        self.tags = @"&tags=cat";
        
    }
    self.tags = [NSString stringWithFormat:@"&tags=%@",tags];

}

-(void)setBool {
    
    self.isNew = YES;
    [self URLSetup];

}



@end
