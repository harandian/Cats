//
//  FlickrCollectionViewCell.h
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Hirad Harandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flickr.h"

@interface FlickrCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *flickrImage;
@property (strong, nonatomic) IBOutlet UILabel *flickrLabel;

@end
