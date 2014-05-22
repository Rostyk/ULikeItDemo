//
//
//  Created by Ros Stepanyak on 5/17/2014
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "Networking.h"

@interface UDHTTPClient : AFHTTPRequestOperationManager

/* Utlilizes main AFNetworking HTTP methods. (Refer to HeadersSerializer group to check the headers) */
    
//shared client instance
+(instancetype)client;
    
//adds auth_token header for all the further requests
-(void)setAuthorizationHeaderFieldWithToken:(NSString *)token;
    
@end
