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
@property (nonatomic, strong)  Location * destino;
@property (nonatomic, strong)  GMSMapView *mapView;
@property (nonatomic, strong)  NSString *direccionOrigen;
@property (nonatomic, strong)  NSString *direccionDestino;
@property (nonatomic, assign)  Float32 latitudeD;
@property (nonatomic, assign)  Float32 longitudeD;
@property (nonatomic, assign)  Float32 latitudeO;
@property (nonatomic, assign)  Float32 longitudeO;
@end

@implementation ViewControllerMapDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    //Assign it to the singleton of MobileApplication...
    MobileApplication *mainApp = [MobileApplication sharedInstance];
    Request *currentRequest = [mainApp currentRequest];
    Location * origen =[currentRequest originLocation];
    self.destino = [currentRequest destinationLocation];
    
    [self searchCoordinatesForAddressOrigin:origen.street number:origen.houseNumbering];
    [self searchCoordinatesForAddressDestino:self.destino.street number:self.destino.houseNumbering];
    [self confingMapWithOrigen:self.latitudeO with:self.longitudeO with:self.direccionOrigen withDestino:self.latitudeD with:self.longitudeD with:self.direccionDestino];

   
}

- (void) searchCoordinatesForAddressOrigin:(NSString *)street number:(NSString *)housenumber
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@+%@,+Mar+del+Plata,+Buenos Aires,+Argentina&sensor=true_or_false",housenumber,street];
    
    //Replace Spaces with a '+' character.
    [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    //Create NSURL string from a formate URL string.
    NSURL *url = [NSURL URLWithString:urlString];
    
     NSData * data=[NSData dataWithContentsOfURL:url];
    
    //The string received from google's servers
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //JSON Framework magic to obtain a dictionary from the jsonString.
    NSDictionary *partialJsonDict = [[[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] objectForKey:@"results"] objectAtIndex:0];
    NSDictionary *geometryDict = [partialJsonDict objectForKey:@"geometry"];
    //Now we need to obtain our coordinates
    self.latitudeO = [[[geometryDict objectForKey:@"location"] objectForKey:@"lat"] floatValue];
    self.longitudeO = [[[geometryDict objectForKey:@"location"] objectForKey:@"lng"] floatValue];
    self.direccionOrigen = [partialJsonDict objectForKey:@"formatted_address"];
    
}

- (void) searchCoordinatesForAddressDestino:(NSString *)street number:(NSString *)housenumber
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@+%@,+Mar+del+Plata,+Buenos Aires,+Argentina&sensor=true_or_false",housenumber,street];
    
    //Replace Spaces with a '+' character.
    [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    //Create NSURL string from a formate URL string.
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    //The string received from google's servers
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //JSON Framework magic to obtain a dictionary from the jsonString.
    NSDictionary *partialJsonDict = [[[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] objectForKey:@"results"] objectAtIndex:0];
    NSDictionary *geometryDict = [partialJsonDict objectForKey:@"geometry"];
    //Now we need to obtain our coordinates
    self.latitudeD = [[[geometryDict objectForKey:@"location"] objectForKey:@"lat"] floatValue];
    self.longitudeD = [[[geometryDict objectForKey:@"location"] objectForKey:@"lng"] floatValue];
    self.direccionDestino = [partialJsonDict objectForKey:@"formatted_address"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)confingMapWithOrigen:(Float32)latitud with:(Float32)longitud with:(NSString *)direccion withDestino:(Float32)latitudD with:(Float32)longitudD with:(NSString *)direccionD
{
 
    //Map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitud
                                                            longitude:longitud
                                                                 zoom:15];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    marker.position=CLLocationCoordinate2DMake(latitud, longitud);
    marker.title=@"Tu pedido";
    marker.snippet=direccion;
    marker.map = _mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position=CLLocationCoordinate2DMake(latitudD, longitudD);
    marker2.title=direccionD;
    marker.snippet=direccionD;
    marker2.map = _mapView;
    self.view = _mapView;
}

- (UITabBarItem *)tabBarItem
{
    return [[UITabBarItem alloc] initWithTitle:@"Recorrido" image:[UIImage imageNamed:@"map-icon2.png"] tag:1];
}




@end
