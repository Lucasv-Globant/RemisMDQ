//
//  Vehicle.h
//  Remisse MDQ prototype
//
//  Created by Globant iOS MDQ on 12/29/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

#import "Agency.h"
#import "Location.h"
#import "MobileApplication.h"

@interface Vehicle : NSObject

typedef enum {
                    VehicleModelNotSpecified = 0,
                    VehicleModelCorsa = 1,
                    VehicleModelMegane = 2,
                    VehicleModelLogan = 3,
                    VehicleModelC4 = 4,
                    VehicleModelSiena = 5
} VehicleModel;

typedef enum {
    VehicleColorNotSpecified = 0,
    VehicleColorGray = 1,
    VehicleColorSilver = 2,
    VehicleColorWhite = 3,
    VehicleColorBlack = 4,
    VehicleColorRed = 5,
    VehicleColorBlue = 6
} VehicleColor;

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSDate *created_at;
@property (nonatomic, strong) NSDate *updated_at;

@property VehicleModel model;
@property VehicleColor color;
@property (nonatomic,strong) NSString *licensePlate;
@property (nonatomic, strong) Agency * agency;
@property (nonatomic, strong) Location *lastKnownLocation;

-(id)init;
-(NSDictionary *)outputToDictionary;
@end
