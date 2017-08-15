//
//  Flickr.h
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Hirad Harandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import CoreLocation;
@import MapKit;

@interface Flickr : NSObject <MKAnnotation>
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *farm;
@property (nonatomic, strong) NSString *photoID;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property(nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSURL *)imageURL;
//- (void)setTitle:(NSString *)title;
//- (void)setSubtitle:(NSString *)subtitle;

@end
