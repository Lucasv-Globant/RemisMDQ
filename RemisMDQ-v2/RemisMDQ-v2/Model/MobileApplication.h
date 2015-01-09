//
//  MobileApplication.h
//  RemisMDQ
//
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

/* -----------------------------------------------------------------------------------
*   MobileApplication: This is the object that contains the state of the mobile
*   application, including the user and current request data, if there is one.
*   The class implements a singleton pattern. Thus, its' data can be accessed at any time
*   from anywhere within the application.
*
*  ---------------------------------------------------------------------------------  */


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

// As of the first version, the MobileApplication contains only one instance of each (user, request, vehicle), but
// the syntax for getters "get(...)WithObjectId:" is intended for reusability and future scalability.
-(User *)getUserWithObjectId:(NSString *)objectId;
-(Agency *)getAgencyWithObjectId:(NSString *)objectId;
-(Vehicle *)getVehicleWithObjectId:(NSString *)objectId;

@end
