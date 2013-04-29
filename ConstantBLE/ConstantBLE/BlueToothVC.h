//
//  BlueToothVC.h
//  ConstantBLE
//
//  Created by Main on 4/29/13.
//  Copyright (c) 2013 AKndShak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BlueToothVC : UIViewController <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *cbCentralManager;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
