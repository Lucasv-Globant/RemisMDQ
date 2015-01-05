//
//  Facade.m
//  RemisMDQ
//
//  Created by Analia on 1/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Facade.h"
#import <Parse/Parse.h>


@interface Facade ()
@property (nonatomic,copy) Success successBlock;
@property (nonatomic,copy) Failure failureBlock;
@end

@implementation Facade

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] initWithParse];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(instancetype)initWithParse
{
    self = [super init];
    // Initialize Parse.
    [Parse setApplicationId:@"O6cpaYEBcpwdiT8mkWUwnmVX00d1gE3BqYp2IfGG"
                  clientKey:@"ve4YmZrV6RgHKcLgttBie5pmMlJviyAKPSDo4PAY"];
    return self;
}

-(void)insertRequestDataInParse:(Success)success failure:(Failure)failure data:(Request *)requestSave
{
    PFObject * request = [PFObject objectWithClassName:@"Pedidos"];
    [request setObject:[NSNumber numberWithInt:[requestSave statusCode]] forKey:@"statusCode"];
    [request setObject:[requestSave originLocation] forKey:@"originLocation"];
    [request setObject:[requestSave destinationLocation] forKey:@"destinationLocation"];
    [request setObject:[requestSave ETAToSourceLocation] forKey:@"ETAToSourceLocation"];
    [request setObject:[requestSave ETAFromSourceLocationToDestinationLocation] forKey:@"ETAFromSourceLocationToDestinationLocation"];
    PFObject * user = [PFObject objectWithClassName:@"usuario"];
    [user setObject:[requestSave user] forKey:@"usuario"];
    [request setObject:user forKey:@"usuario"];
    PFObject * vehicle =[PFObject objectWithClassName:@"coche"];
    [vehicle setObject:[requestSave vehicle] forKey:@"vehicle"];
    [request setObject:vehicle forKey:@"coche"];
    [request save];
}

-(void)findInParse:(Success)success failure:(Failure)failure
{

}

-(void)updateInParse:(Success)success failure:(Failure)failure
{
    
}

-(void)deleteInPase:(Success)success failure:(Failure)failure
{
    
}

@end
