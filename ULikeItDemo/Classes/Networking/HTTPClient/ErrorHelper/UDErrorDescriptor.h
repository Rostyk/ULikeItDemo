//
//  DCErrorDescriptor.h
//  Discount Cab 2.0
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDErrorDescriptor : NSObject

+ (NSUInteger)statusCodeOfNetworkError:(NSError *)error;
+ (NSError *)errorTranslatedFromNetworkError:(NSError *)error responseObject:(id)responseObject;
@end
