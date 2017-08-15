//
//  AppDelegate.h
//  Cats
//
//  Created by Elle Ti on 2017-08-14.
//  Copyright © 2017 Hirad Harandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

