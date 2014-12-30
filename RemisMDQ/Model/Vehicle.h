//
//  Vehicle.h
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import "Agency.h"
#import "Location.h"

@interface Vehicle : NSObject

typedef enum {
                    Corsa,
                    Megane,
                    Logan,
                    C4,
                    Siena
} VehicleModel;

typedef enum {
    Gray,
    Silver,
    White,
    Black,
    Red,
    Blue
} VehicleColor;

@property VehicleModel model;
@property VehicleColor color;
@property (nonatomic,strong) NSString *licensePlate;
@property (nonatomic, strong) Agency *agency;
@property (nonatomic, strong) Location *lastKnownLocation;

@end
