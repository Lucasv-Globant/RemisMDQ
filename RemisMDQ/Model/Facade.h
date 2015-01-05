//
//  Facade.h
//  RemisMDQ
//
//  Created by Analia on 1/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
typedef void (^Success)(NSMutableDictionary * dic);
typedef void (^Failure)(NSError* error);
@interface Facade : NSObject

#pragma mark - Singleton
+ (id)sharedInstance;

#pragma mark - Method
-(void)insertRequestDataInParse:(Success)success failure:(Failure)failure data:(Request *)requestSave;
-(void)findInParse:(Success)success failure:(Failure)failure with:(NSString *)Id in:(NSString *)from;
-(void)updateRequestInParse:(Success)success failure:(Failure)failure with:(NSString *)Id data:(NSDictionary *)dataUpdate;
-(void)deleteInPase:(Success)success failure:(Failure)failure with:(NSString *)Id in:(NSString *)from;

@end
