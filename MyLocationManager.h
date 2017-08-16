//
//  MyLocationManager.h
//  Cats
//
//  Created by Hirad on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol MyLocationManagerDelegate <NSObject>

-(void) passCurrentLocation: (CLLocation*)location;

@end

@interface MyLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id<MyLocationManagerDelegate> delegate;

-(void) startLocationManager;
+(MyLocationManager*) sharedManager;


@end
