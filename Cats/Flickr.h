//
//  Flickr.h
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Flickr : NSObject
@property (nonatomic, weak) NSString *server;
@property (nonatomic, weak) NSString *farm;
@property (nonatomic, weak) NSString *photoID;
@property (nonatomic, weak) NSString *secret;
@property (nonatomic, weak) NSString *title;

- (instancetype)initWithFarm:(NSString *)farm andServerID:(NSString *)photoID andServer:(NSString *)server andSecret:(NSString *)secret andTitle:(NSString *)title;

@end
