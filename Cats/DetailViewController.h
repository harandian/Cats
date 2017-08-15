//
//  DetailViewController.h
//  Cats
//
//  Created by Hirad on 2017-08-15.
//  Copyright © 2017 Hirad Harandian. All rights reserved.
//

#import "ViewController.h"
@import  MapKit;
#import "Flickr.h"

@interface DetailViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) Flickr *photoToShow; 


- (void)addAnnotation:(id<MKAnnotation>)annotation;



@end
