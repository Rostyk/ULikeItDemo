//
//  RSYellowAPIClient.m
//
//  Created by Ros Stepanyak on 5/17/2014
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "UDHTTPClient.h"
#import "UDRequestSerializer.h"
@interface UDHTTPClient ()

@end

@implementation UDHTTPClient

//shared client instance
+ (instancetype)client
{
    static UDHTTPClient *_sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UDHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kServerBaseURL]];
    });
    
    return _sharedInstance;
}

#pragma mark -
#pragma mark Custom initialization

-(id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        /*our custom serializer to add some headers to all the requests*/
        self.requestSerializer = [UDRequestSerializer new];
        
        [self.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    }
    
    return self;
}

//adds auth_token header for all the further requests
-(void)setAuthorizationHeaderFieldWithToken:(NSString *)token {
        [(UDRequestSerializer *)self.requestSerializer setAuthorizationHeaderFieldWithToken: [self encodedString: token]];
}
    
-(NSString *)encodedString: (NSString*) string {
        return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

#pragma mark -
#pragma mark Custom Server Methods

-(AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    AFHTTPRequestOperation *operation = [super POST:URLString parameters:parameters success:success failure:failure];
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:nil];
    return operation;
}

-(AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    AFHTTPRequestOperation *operation = [super GET:URLString parameters:parameters success:success failure:failure];
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:nil];
    return operation;
}

-(AFHTTPRequestOperation *) FETCH_IMAGE:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    AFHTTPRequestOperation *operation = [super FETCH_IMAGE:URLString parameters:parameters success:success failure:failure];
    [operation setShouldExecuteAsBackgroundTaskWithExpirationHandler:nil];
    return operation;
}



    
@end
