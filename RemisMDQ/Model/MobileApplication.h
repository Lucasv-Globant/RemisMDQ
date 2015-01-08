//
//  MobileApplication.h
//  RemisMDQ
//
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "User.h"
#import "Request.h"
#import "Facade.h"
#import "Vehicle.h"

@class Vehicle;
@class Request;
@interface MobileApplication : NSObject

//Since this is a mobile application, we store the request, agency, vehicle directly as properties for simpler saving/recovery
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Request *currentRequest;
@property (nonatomic, strong) Agency *agencyOfCurrentRequest;
@property (nonatomic, strong) Vehicle *vehicleOfCurrentRequest;


+ (id)sharedInstance;
-(User *)getUserWithObjectId:(NSString *)objectId;
-(Agency *)getAgencyWithObjectId:(NSString *)objectId;
-(Vehicle *)getVehicleWithObjectId:(NSString *)objectId;

@end
