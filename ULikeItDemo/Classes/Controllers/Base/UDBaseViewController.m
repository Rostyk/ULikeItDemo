//
//  ADBaseViewController.m
//  AuthorizationDemoForMadeo
//
//  Created by Rostyslav Stepanyak on 5/17/14.
//  Copyright (c) 2014 Rostyslav Stepanyak. All rights reserved.
//

#import "UDBaseViewController.h"
#import "UDPreloadManager.h"

@interface UDBaseViewController ()

@end

@implementation UDBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
    
-(void) addPreload {
    [[UDPreloadManager sharedManager] addPreloadToView: self.view spinnerOffset: 0];
}
    
-(void) removePreload {
    [[UDPreloadManager sharedManager] removePreloadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
