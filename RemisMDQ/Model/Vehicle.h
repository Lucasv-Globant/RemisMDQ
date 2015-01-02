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
                    VehicleModelNotSpecified,
                    VehicleModelCorsa,
                    VehicleModelMegane,
                    VehicleModelLogan,
                    VehicleModelC4,
                    VehicleModelSiena
} VehicleModel;

typedef enum {
    VehicleColorNotSpecified,
    VehicleColorGray,
    VehicleColorSilver,
    VehicleColorWhite,
    VehicleColorBlack,
    VehicleColorRed,
    VehicleColorBlue
} VehicleColor;

@property VehicleModel model;
@property VehicleColor color;
@property (nonatomic,strong) NSString *licensePlate;
@property (nonatomic, strong) Agency *agency;
@property (nonatomic, strong) Location *lastKnownLocation;

-(id)init;

@end
