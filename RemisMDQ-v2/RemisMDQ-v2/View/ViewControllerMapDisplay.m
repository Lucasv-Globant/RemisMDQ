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

@interface ViewControllerMapDisplay () 


@end

@implementation ViewControllerMapDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
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
