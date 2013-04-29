//
//  BlueToothVC.m
//  ConstantBLE
//
//  Created by Main on 4/29/13.
//  Copyright (c) 2013 AKndShak. All rights reserved.
//

#import "BlueToothVC.h"

@interface BlueToothVC ()
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;
@end

@implementation BlueToothVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cbCentralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

- (void)startScan
{
    if (self.cbCentralManager.state == CBCentralManagerStatePoweredOn)
    {
        [self.cbCentralManager scanForPeripheralsWithServices:nil
                                                      options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
    }
}

- (void)updateTextView:(NSString *)aString
{
    self.textView.text = [self.textView.text stringByAppendingString:aString];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn)
    {
        [self startScan];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (self.discoveredPeripheral != peripheral && [peripheral.name rangeOfString:@"Keyfob"].location != NSNotFound)
    {
        self.discoveredPeripheral = peripheral;
        [self.cbCentralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self updateTextView:@"Connected to Peripheral.\n"];
    [self.cbCentralManager stopScan];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSString *string = [NSString stringWithFormat:@"Failed to connect to Peripheral. Error message: %@\n", error.localizedDescription];
    [self updateTextView:string];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (error){
        NSString *string = [NSString stringWithFormat:@"Disconnected from Peripheral. Error message: %@\n", error.localizedDescription];
        [self updateTextView:string];
    }
    else {
        [self updateTextView:@"Disconnected from Peripheral."];
    }
    [self startScan];
}

@end
