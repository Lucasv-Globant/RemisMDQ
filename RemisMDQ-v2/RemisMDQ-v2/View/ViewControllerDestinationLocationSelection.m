//
//  ViewControllerDestinationLocationSelection.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/15/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerDestinationLocationSelection.h"

@interface ViewControllerDestinationLocationSelection ()
@property (strong, nonatomic) IBOutlet UITextField *textFieldHouseNumbering;
@property (strong, nonatomic) IBOutlet UITextField *textFieldStreet;


@end

@implementation ViewControllerDestinationLocationSelection

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToNextScreen:(id)sender {
    NSMutableDictionary *locationValues = [[NSMutableDictionary alloc] init];
    
    [locationValues setObject:@"Mar del Plata" forKey:@"city"];
    [locationValues setObject:[[self textFieldStreet] text] forKey:@"streetName"];
    [locationValues setObject:[[self textFieldHouseNumbering] text] forKey:@"houseNumbering"];
    
    
    if ([LocationServices locationValuesAreValid:locationValues])
        //If all is Ok, proceed with the creation of the location and go to the next screen...
    {
        //Create the location
        Location *destination = [[Location alloc] init];
        [destination setCountry:@"Argentina"];
        [destination setProvince:@"Buenos Aires"];
        [destination setZipCode:@"7600"];
        [destination setCity:@"Mar del Plata"];
        [destination setStreet:[[self textFieldStreet] text]];
        [destination setHouseNumbering:[[self textFieldHouseNumbering] text]];
        //Assign it to the singleton of MobileApplication...
        MobileApplication *mainApp = [MobileApplication sharedInstance];
        Request *currentRequest = [mainApp currentRequest];
        [currentRequest setDestinationLocation:destination];
        
        //Push the view controller of the next screen...
        ViewControllerCurrentRequestDisplay *currentRequestScreen = [[ViewControllerCurrentRequestDisplay alloc] initWithNibName:@"ViewControllerCurrentRequestDisplay" bundle:nil];
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        
        ViewControllerMapDisplay *mapScreen = [[ViewControllerMapDisplay alloc] initWithNibName:@"ViewControllerMapDisplay" bundle:nil];
        
        ViewControllerVehicleInformation *vehicleInformation = [[ViewControllerVehicleInformation alloc] initWithNibName:@"ViewControllerVehicleInformation" bundle:nil];
        
        tabBarController.viewControllers = [NSArray arrayWithObjects:
                                            currentRequestScreen,
                                            vehicleInformation,
                                            mapScreen,
                                            nil];
        
        // set as the root window
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:tabBarController];
    }
    else
    {
        //The values entered are not valid
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
