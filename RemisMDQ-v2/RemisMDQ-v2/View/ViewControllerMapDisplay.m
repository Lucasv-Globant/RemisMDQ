//
//  ViewControllerMapDisplay.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/19/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerMapDisplay.h"
#import "MobileApplication.h"
#import "Request.h"
#import "Location.h"

@interface ViewControllerMapDisplay () 


@end

@implementation ViewControllerMapDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    //Assign it to the singleton of MobileApplication...
    MobileApplication *mainApp = [MobileApplication sharedInstance];
    Request *currentRequest = [mainApp currentRequest];
    Location * origen =[currentRequest originLocation];
    Location * destino = [currentRequest destinationLocation];
    NSLog(@"origen:%@ destino:%@",origen.street,destino);
    
    [self searchCoordinatesForAddress:origen.street number:origen.houseNumbering];
    
    
   
}

- (void) searchCoordinatesForAddress:(NSString *)street number:(NSString *)housenumber
{
    //Build the string to Query Google Maps.
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@+%@,+Mar+del+Plata,+Buenos Aires,+Argentina&sensor=true_or_false",housenumber,street];
    
    //Replace Spaces with a '+' character.
    [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    //Create NSURL string from a formate URL string.
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Setup and start an async download.
    //Note that we should test for reachability!.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //The string received from google's servers
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //JSON Framework magic to obtain a dictionary from the jsonString.
    // NSDictionary *results = [jsonString JSONValue];
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSLog(@"%@",results);
    
    //Now we need to obtain our coordinates
    NSDictionary *placemark  = [results objectForKey:@"geometry"];
    NSDictionary *coordinates = [placemark  valueForKeyPath:@"location"];
    
    //I put my coordinates in my array.
    double longitude = [[coordinates valueForKey:@"lng"] doubleValue];
    double latitude = [[coordinates valueForKey:@"lat" ] doubleValue];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-38.010878
                                                            longitude:-57.535789
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Hello World";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    self.view = mapView;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITabBarItem *)tabBarItem
{
    return [[UITabBarItem alloc] initWithTitle:@"Recorrido" image:[UIImage imageNamed:@"map-icon2.png"] tag:1];
}




@end
