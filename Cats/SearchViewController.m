//
//  SearchViewController.m
//  Cats
//
//  Created by Hirad on 2017-08-15.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "SearchViewController.h"



@interface SearchViewController () <MyLocationManagerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) NSString *tags;
@property CLLocationCoordinate2D currentLocation;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)disMiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self.delegate sendData:self.currentLocation];
        [self.delegate sendTags:self.tags];
        [self.delegate setBool];

    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    self.tags = textField.text;
    self.tags = [self.tags stringByReplacingOccurrencesOfString:@", " withString:@"%2C"];
    
    
    return NO;
    
}

- (IBAction)location:(id)sender {
    
    NSLog(@"Switch");
    MyLocationManager *tempManager = [MyLocationManager sharedManager];
    tempManager.delegate = self;
    [tempManager startLocationManager];
    NSLog(@"%@", tempManager.delegate);
    
    
}

- (void)passCurrentLocation:(CLLocation *)location {

    self.currentLocation = location.coordinate;
    
}

@end

