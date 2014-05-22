//
//  ADBaseViewController.h
//  AuthorizationDemoForMadeo
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2014 Rostyslav Stepanyak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UDBaseViewController : UIViewController
    
//place loading graphics (half-transparent subview covering entirely screen with activitity indicator spinning)
- (void) addPreload;
    
//remove preload graphics (if one is added, if not added the call will do nothing), mustn't be sequenced with addPrelaod, can be called multiple times in a row
- (void) removePreload;
@end
