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

-(void)insertRequestDataInParse:(Request *)requestSave
{
    PFObject * request = [PFObject objectWithClassName:@"Request"];
    [request setObject:[NSNumber numberWithInt:[requestSave statusCode]] forKey:@"statusCode"];
    [request setObject:[requestSave originLocation] forKey:@"originLocation"];
    [request setObject:[requestSave destinationLocation] forKey:@"destinationLocation"];
    [request setObject:[requestSave ETAToSourceLocation] forKey:@"ETAToSourceLocation"];
    [request setObject:[requestSave ETAFromSourceLocationToDestinationLocation] forKey:@"ETAFromSourceLocationToDestinationLocation"];
    PFObject * user = [PFObject objectWithClassName:@"User"];
    [user setObject:[requestSave user] forKey:@"user"];
    [request setObject:user forKey:@"user"];
    PFObject * vehicle =[PFObject objectWithClassName:@"Vehicle"];
    [vehicle setObject:[requestSave vehicle] forKey:@"vehicle"];
    [request setObject:vehicle forKey:@"vehicle"];
    [request saveInBackground];
}

-(void)updateRequestInParseWith:(NSString *)Id data:(NSDictionary *)dataUpdate
{
    //Actualizo en Parse segun la info que me llega en el diccionario y en la tabla traida por el from
    PFQuery * query = [PFQuery queryWithClassName:@"Request"];
    [query getObjectInBackgroundWithId:Id block:^(PFObject *object, NSError *error) {
        object[@"statusCode"] = [dataUpdate valueForKey:@"statusCode"];
        object[@"originLocation"] = [dataUpdate valueForKey:@"originLocation"];
        object[@"destinationLocation"] = [dataUpdate valueForKey:@"destinationLocation"];
        object[@"ETAToSourceLocation"] = [dataUpdate valueForKey:@"ETAToSourceLocation"];
        object [@"ETAFromSourceLocationToDestinationLocation"] = [dataUpdate valueForKey:@"ETAFromSourceLocationToDestinationLocation"];
        object [@"user"] = [dataUpdate valueForKey:@"user"];
        object [@"vehicle"] = [dataUpdate valueForKey:@"vehicle"];
        [object saveInBackground];
 
    }];
    
}

-(void)findInParseWith:(NSString *)Id in:(NSString *)from
{
    //busco en parse por un Id en el nsstring que llega al final del parametro
    PFQuery * query = [PFQuery queryWithClassName:from];
    [query getObjectInBackgroundWithId:Id block:^(PFObject *object, NSError *error) {
        NSLog(@"Econtro esta cantidad de objetos %@",object);
    }];
    
}

-(void)deleteInPaseWith:(NSString *)Id in:(NSString *)from
{
    PFQuery * query =[PFQuery queryWithClassName:from];
    [query getObjectInBackgroundWithId:Id block:^(PFObject *object, NSError *error) {
        [object deleteInBackground];
        NSLog(@"Delete is Ok");
    }];
}

@end
