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

@interface ViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *flickrArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self URLSetup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - URL Request Info
- (void)URLSetup
{
    self.flickrArray = [NSMutableArray array];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=51fe506858b9869a0fb583d7f206ef60&tags=cat&has_geo=1&extras=url_m%2C+geo&format=json&nojsoncallback=1&auth_token=72157687553703346-0cd04e245f0ba204&api_sig=232733fb053c7bc850c75c29154fd101"];
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
            
            for (NSDictionary *flickr in photoArray)
            {
                Flickr * image = [[Flickr alloc] initWithDictionary:flickr];
                [self.flickrArray addObject:image];
                NSLog(@"%@",self.flickrArray);

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
    
   DetailViewController *detailViewController = [segue destinationViewController];
   
    NSIndexPath *indexPath = [self.collectionView indexPathsForSelectedItems].firstObject;
    
    Flickr *photoToShow = self.flickrArray[indexPath.item];
    
    detailViewController.photoToShow = photoToShow;
    
    
}



@end
