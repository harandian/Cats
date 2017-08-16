//
//  SearchViewController.h
//  Cats
//
//  Created by Hirad on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ViewController.h"
#import "MyLocationManager.h"
@import CoreLocation;

@protocol setLocation <NSObject>

-(void) sendData: (CLLocationCoordinate2D) currentLocation;
-(void) sendTags: (NSString *)tags;
-(void) setBool;
@end


@interface SearchViewController : ViewController <UITextFieldDelegate>

@property (weak, nonatomic) id<setLocation> delegate;
@property CLLocation *userLoc;


@end
