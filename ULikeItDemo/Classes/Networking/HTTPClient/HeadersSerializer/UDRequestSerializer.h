//
//  GFCRequestSerializer.h
//  Yellow
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "AFURLRequestSerialization.h"

@interface UDRequestSerializer : AFJSONRequestSerializer

/*Arranges all the necessary header fields for requests */
    
//add auth token header into serializer
-(void) setAuthorizationHeaderFieldWithToken:(NSString *)token;

@end
