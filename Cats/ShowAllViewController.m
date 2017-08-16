//
//  ShowAllViewController.m
//  Cats
//
//  Created by Hirad on 2017-08-16.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ShowAllViewController.h"
@import MapKit;
@import UIKit;



@interface ShowAllViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *showAllMap;

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    for (int i =0 ; i < self.pinArray.count; i ++)
//    {
//        [self addAnnotation:self.pinArray[i]];
//    }
//    
    [self.showAllMap showAnnotations:self.pinArray animated:NO];

}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    
    static NSString* RedPin = @"redPin";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:RedPin];
    if (!pinView) {
        
//        for (int i = 0 ; i < self.pinArray.count; i++)
//        {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:RedPin];
            pinView.pinTintColor = [UIColor magentaColor];
            pinView.animatesDrop = YES;
//        }
    }
    return pinView;
}

//- (void)addAnnotation:(id<MKAnnotation>)annotation {
//    
//    [self.showAllMap addAnnotation:annotation];
//    //   [self.showAllMap addAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#>]
////    [self.showAllMap showAnnotations:@[annotation] animated:YES];
//
//    
//}

@end
