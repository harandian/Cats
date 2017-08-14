//
//  Flickr.m
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "Flickr.h"

@implementation Flickr
- (instancetype)initWithFarm:(NSString *)farm andServerID:(NSString *)photoID andServer:(NSString *)server andSecret:(NSString *)secret andTitle:(NSString *)title
{
    if (self = [super init])
    {
        _farm = farm;
        _photoID = photoID;
        _server = server;
        _secret = secret;
        _title = title;
    }
    return self;
}

@end
