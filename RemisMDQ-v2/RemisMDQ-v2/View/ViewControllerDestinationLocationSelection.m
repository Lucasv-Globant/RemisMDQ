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
@property (nonatomic, retain) NSMutableArray *autocompleteUrls;
@property (strong, nonatomic) IBOutlet UITableView *autocompleteTableView;

@property (nonatomic, strong)  NSMutableArray *pastUrls;

@end

@implementation ViewControllerDestinationLocationSelection

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autocompleteUrls = [[NSMutableArray alloc] init];
    self.pastUrls = [[NSMutableArray alloc] initWithObjects:@"Av.Colon",@"Brown",@"Av.Jara",@"Bolivar", nil];

    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
    self.autocompleteTableView.hidden = YES;
    [self.view addSubview:self.autocompleteTableView];
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

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    
    [self.autocompleteUrls removeAllObjects];
    for(NSString *curString in self.pastUrls) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.autocompleteUrls addObject:curString];
        }
    }
    [self.autocompleteTableView reloadData];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [self.autocompleteUrls objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.textFieldStreet.text = selectedCell.textLabel.text;
    self.autocompleteTableView.hidden = true;
    
    
    
}


@end
