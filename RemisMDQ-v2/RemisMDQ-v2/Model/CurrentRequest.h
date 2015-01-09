//
//  CurrentRequest.h
//  RemisMDQ
//
//  Created by Lucas on 12/30/14.
//  Copyright (c) 2014 Globant iOS MDQ. All rights reserved.
//

/* ---------------------------------------------------------------
*  This class represents the current request, if there's one
*  It is a singleton of the Request class. 
*  For now, we allow only one request per user for the entire app
*  at a time
*/


#import "Request.h"

@interface CurrentRequest : Request

+ (id)sharedInstance;

@end
