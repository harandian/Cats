//
//  MyLocationManager.m
//  Cats
//
//  Created by Hirad on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "MyLocationManager.h"
@import UIKit;

@interface MyLocationManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;


@end

@implementation MyLocationManager

+(MyLocationManager*) sharedManager {
    static MyLocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
    });
    
    return sharedManager;
}

-(void) startLocationManager {
    
    // if this phone can do location Services
    if ([CLLocationManager locationServicesEnabled]) {
        
        // if authorizationStatus == kCLAuthorizationStatusDenied, kCLAuthorizationStatusRestricted, kCLAuthorizationStatusNotDetermined
        if ((!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)) || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
            [self setUpLocationManager];
            
        }else{
            
            //show an alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location services are disabled, Please go into Settings > Privacy > Location to enable them for Play" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                
                
            }];
            
            
            [alertController addAction:ok];
            [alertController addAction:cancel];
            
        }
        
    }
    
}

-(void)setUpLocationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        // if are Google Maps
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.distanceFilter = 10; //have to move 10m before location manager checks again
        
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        NSLog(@"new location Manager in startLocationManager");
    }
    [_locationManager startUpdatingLocation];
    NSLog(@"Start Regular Location Manager");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //last object because we care about current location
    CLLocation * loc = [locations lastObject];
    
    NSLog(@"Time %@, latitude %+.6f, longitude %+.6f currentLocation accuracy %1.2f loc accuracy %1.2f timeinterval %f",[NSDate date],loc.coordinate.latitude, loc.coordinate.longitude, loc.horizontalAccuracy, loc.verticalAccuracy, fabs([loc.timestamp timeIntervalSinceNow]));
    
    
    // Filters for location
    
    //Check that the age is not long ago
    NSTimeInterval locationAge = -[loc.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0){
        NSLog(@"locationAge is %1.2f",locationAge);
        return;
    }
    
    //Check that horizontal Arrucacry is not invalid
    if (loc.horizontalAccuracy < 0){
        NSLog(@"loc.horizontalAccuracy is %1.2f",loc.horizontalAccuracy);
        return;
    }
    
    if (self.currentLocation == nil || self.currentLocation.horizontalAccuracy >= loc.horizontalAccuracy){
        
        self.currentLocation = loc;
        [self.delegate passCurrentLocation:self.currentLocation];
        
        //Stop location Manager if we reached an a location within our acceptable desiredAccuracy
        if (loc.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            [self stopLocationManager];
        }
    }
    
}

-(void)stopLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        if (_locationManager) {
            // Dont fire delegate methods anymore.
            [_locationManager stopUpdatingLocation];
            NSLog(@"Stop Regular Location Manager");
        }
    }
}

@end
