//
//  FlickrCollectionViewCell.h
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flickr.h"

@interface FlickrCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *flickrImage;
@property (weak, nonatomic) IBOutlet UILabel *flickrLabel;

@end
