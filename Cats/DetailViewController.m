//
//  DetailViewController.m
//  Cats
//
//  Created by Hirad on 2017-08-15.
//  Copyright © 2017 Hirad Harandian. All rights reserved.
//

#import "DetailViewController.h"
@import UIKit;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *cityName;

@end

@implementation DetailViewController

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.photoToShow.title;
    [self addAnnotation:self.photoToShow];
    [self setCountry];
    
    
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString* RedPin = @"redPin";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:RedPin];
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:self.photoToShow reuseIdentifier:RedPin];
        pinView.pinTintColor = [UIColor magentaColor];
        pinView.animatesDrop = YES;
        UILabel *lblName=[[UILabel alloc] init];
        lblName.font=[UIFont systemFontOfSize:12];
        lblName.textAlignment=UITextAlignmentCenter;
        lblName.textColor=[UIColor whiteColor];
        lblName.backgroundColor=[UIColor clearColor];
        lblName.text= self.photoToShow.title;
        [pinView addSubview:lblName];
        pinView.canShowCallout = YES;
        [pinView setEnabled:YES];
    }
    return pinView;
}

- (void)addAnnotation:(id<MKAnnotation>)annotation {
    
    [self.mapView addAnnotation:annotation];
    [self.mapView showAnnotations:@[annotation] animated:YES];
    
}

- (void) setCountry {
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:self.photoToShow.coordinate.latitude longitude:self.photoToShow.coordinate.longitude]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  if (placemark) {
                      
                      
                      NSLog(@"placemark %@",placemark);
                      //String to hold address
                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                      NSLog(@"addressDictionary %@", placemark.addressDictionary);
                      
                      NSLog(@"placemark %@",placemark.region);
                      NSLog(@"placemark %@",placemark.country);  // Give Country Name
                      NSLog(@"placemark %@",placemark.locality); // Extract the city name
                      NSLog(@"location %@",placemark.name);
                      NSLog(@"location %@",placemark.ocean);
                      NSLog(@"location %@",placemark.postalCode);
                      NSLog(@"location %@",placemark.subLocality);
                      
                      NSLog(@"location %@",placemark.location);
                      //Print the location to console
                      NSLog(@"I am currently at %@",locatedAt);
                      
                      self.titleLabel.text = placemark.country;
                      self.cityName.text = placemark.locality;

                  }
                  else {
                      NSLog(@"Could not locate");
                  }
              }
     ];
    
}
@end
