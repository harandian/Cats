//
//  ViewController.m
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ViewController.h"
#import "Flickr.h"
#import "FlickrCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) NSMutableArray *flickrArray;

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
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=759da7ef2198dfc69eeaac5f46dd486f&tags=cats"];
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
            
            self.flickrArray = photoArray;
            
            for (NSDictionary *flickr in photoArray)
            {
                
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
    NSDictionary *repo = self.flickrArray[indexPath.item];
    cell.flickrLabel.text = repo[@"title"];
    return cell;
}


@end
