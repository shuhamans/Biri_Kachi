//
//  NPViewController.m
//  ANCS
//
//  Created by uehara akihiro on 2013/10/27.
//  Copyright (c) 2013年 REINFORCE Lab. All rights reserved.
//

#import "NPViewController.h"

//#define DEVICE_NAME @"ANCSNP01"
#define BIRI_NAME @"KACHI-88"     // BIRI
#define KACHI_NAME @"KACHI-87"    // KACHI

@interface NPViewController () {
    CBPeripheralManager *_peripheralManager;
}
@property (weak, nonatomic) IBOutlet UIButton *startBiriButton;
@property (weak, nonatomic) IBOutlet UIButton *startKachiButton;
@end

@implementation NPViewController

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
    
    _startBiriButton.enabled  = NO;
    _startBiriButton.selected = NO;
    
    _startKachiButton.enabled = NO;
    _startKachiButton.selected = NO;
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if([version hasPrefix:@"7" ]) {
        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    } else {
        self.startBiriButton.enabled = NO;
        self.startKachiButton.enabled = NO;
    }
}

#pragma mark CBperipheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if(peripheral.state == CBPeripheralManagerStatePoweredOn) {
        _startBiriButton.enabled = YES;
        _startKachiButton.enabled = YES;
    } else {
        if(_startBiriButton.selected) {
            [_peripheralManager stopAdvertising];
        }
        if (_startKachiButton.selected)
        {
            [_peripheralManager stopAdvertising];
        }
        _startBiriButton.enabled  = NO;
        _startBiriButton.selected = NO;
        _startKachiButton.enabled = NO;
        _startKachiButton.selected = NO;
    }
}

- (IBAction)startBiriBiriButtontouchUpInside:(id)sender {
    if(_startBiriButton.selected) {
//        NSLog(@"stop advertising...");
        [_peripheralManager stopAdvertising];
        _startBiriButton.selected = NO;
    } else {
//        NSLog(@"start advertising...");
        [_peripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey : BIRI_NAME}];
        _startBiriButton.selected = YES;
        [NSThread sleepForTimeInterval:0.02];
        _startBiriButton.selected = NO;
        [_peripheralManager stopAdvertising];
    }
}

- (IBAction)startKachiButtontouchUpInside:(id)sender {
    if(_startKachiButton.selected) {
        //        NSLog(@"stop advertising...");
        [_peripheralManager stopAdvertising];
        _startKachiButton.selected = NO;
    } else {
        //        NSLog(@"start advertising...");
        [_peripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey : KACHI_NAME}];
        _startKachiButton.selected = YES;
        [NSThread sleepForTimeInterval:0.02];
        _startKachiButton.selected = NO;
        [_peripheralManager stopAdvertising];
    }
}


@end
