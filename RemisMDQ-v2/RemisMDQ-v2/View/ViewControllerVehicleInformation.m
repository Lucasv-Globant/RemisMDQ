//
//  ViewControllerVehicleInformation.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/19/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerVehicleInformation.h"

@interface ViewControllerVehicleInformation ()

@end

@implementation ViewControllerVehicleInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITabBarItem *)tabBarItem
{
    return [[UITabBarItem alloc] initWithTitle:@"Coche" image:[UIImage imageNamed:@"car.png"] tag:2];
}




@end
