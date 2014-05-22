//
//  UDImageLaoder.h
//  ULikeItDemo
//
//  Created by Rostyslav Stepanyak on 5/22/14.
//  Copyright (c) 2014 modocache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UDRequestOperationDelegate.h"
#import "UDImageFetchDeleagte.h"

/* Retrieves a bunch of images from web for a test purpose */

@interface UDImageLaoder : NSObject<UDRequestOperationDelegate>

/*downloads images for all the persons*/
-(void) loadImages;

@property (nonatomic, weak) id <UDImageFetchDeleagte> delegate;
@end
