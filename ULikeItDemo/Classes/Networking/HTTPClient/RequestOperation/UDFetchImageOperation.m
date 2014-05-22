//
//  PassengerLoginOperation.m
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import "UDFetchImageOperation.h"
#import "Networking.h"

@interface UDFetchImageOperation ()

@end

@implementation UDFetchImageOperation

-(instancetype)initWithParameters:(NSDictionary *)params delegate:(id<UDRequestOperationDelegate>)delegate imageName: (NSString*) imageName {
    self = [super initWithMethod: [NSString stringWithFormat: @"%@/%@", kAPIFetchImage, imageName] parameters:params context:nil delegate:delegate];
    self.type = RTFetchImage;
    
    return self;
}

- (void)performHandlingResponse:(id)json {
    if ([json isKindOfClass:[UIImage class]]) {
        [super performHandlingResponse:json];
    }
}

-(void)requestFailed:(NSError *)error {
    [super requestFailed:error];
}


@end
