//
//  ViewControllerOriginLocationSelection.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/15/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerOriginLocationSelection.h"

@interface ViewControllerOriginLocationSelection ()
@property (strong, nonatomic) IBOutlet UITextField *textFieldStreet;
@property (strong, nonatomic) IBOutlet UITextField *textFieldHouseNumbering;


@end

@implementation ViewControllerOriginLocationSelection

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (IBAction)goToRecentLocations:(id)sender {
}

- (IBAction)goToNextScreen:(id)sender {
    NSMutableDictionary *locationValues = [[NSMutableDictionary alloc] init];
    
    [locationValues setObject:@"Mar del Plata" forKey:@"city"];
    [locationValues setObject:[[self textFieldStreet] text] forKey:@"streetName"];
    [locationValues setObject:[[self textFieldHouseNumbering] text] forKey:@"houseNumbering"];
    
    
    if ([LocationServices locationValuesAreValid:locationValues])
    {
        //All Ok, proceed with the creation of the location and go to the next screen...
        Location *origin = [[Location alloc] init];
        [origin setCountry:@"Argentina"];
        [origin setProvince:@"Buenos Aires"];
        [origin setZipCode:@"7600"];
        [origin setCity:@"Mar del Plata"];
        [origin setStreet:[[self textFieldStreet] text]];
        [origin setHouseNumbering:[[self textFieldHouseNumbering] text]];
        
        Request *currentRequest = [[MobileApplication sharedInstance] currentRequest];
        [currentRequest setOriginLocation:origin];
        ViewControllerDestinationLocationSelection *nextScreen = [[ViewControllerDestinationLocationSelection alloc] initWithNibName:@"ViewControllerDestinationLocationSelection" bundle:nil];
        [self.navigationController pushViewController:nextScreen animated:YES];
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
