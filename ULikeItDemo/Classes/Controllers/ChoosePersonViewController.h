//
// ChoosePersonViewController.h
//
// Copyright (c) 2014 to present, Brian Gesiak @modocache
//
//  Created by Ros Stepanyak on 5/17/2014
//  Copyright (c) 2013 Treeline Interactive. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ChoosePersonView.h"
#import "UDRequestOperationDelegate.h"
#import "UDBaseViewController.h"

@interface ChoosePersonViewController : UDBaseViewController <MDCSwipeToChooseDelegate, UDRequestOperationDelegate>

@property (nonatomic, strong) Person *currentPerson;
@property (nonatomic, strong) ChoosePersonView *frontCardView;
@property (nonatomic, strong) ChoosePersonView *backCardView;

@end
