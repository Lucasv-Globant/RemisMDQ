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
    /*
    //JSON Framework magic to obtain a dictionary from the jsonString.
    // NSDictionary *results = [jsonString JSONValue];
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSLog(@"%@",results);
    
    //Now we need to obtain our coordinates
    NSArray *placemark  = [results objectForKey:@"results"];
    NSDictionary *dic = [placemark  valueForKeyPath:@"geometry"];
    NSDictionary *coordinates = [dic valueForKey:@"location"];
     //I put my coordinates in my array.
     double longitude = [[coordinates valueForKey:@"lng"] doubleValue];
     double latitude = [[coordinates valueForKey:@"lat" ] doubleValue];
    */
    
    NSDictionary *partialJsonDict = [[[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] objectForKey:@"results"] objectAtIndex:0];
    NSDictionary *geometryDict = [partialJsonDict objectForKey:@"geometry"];
    Float32 latitude = [[[geometryDict objectForKey:@"location"] objectForKey:@"lat"] floatValue];
    Float32 longitude = [[[geometryDict objectForKey:@"location"] objectForKey:@"lng"] floatValue];
    
   
    
    NSLog(@"latitud: %f longitud:%f",latitude,longitude);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
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
