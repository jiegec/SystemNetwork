//
//  SystemNetwork.h
//  SystemNetwork
//
//  Created by MacBookAir on 2018/9/8.
//  Copyright © 2018 Jiajie Chen. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface SystemNetwork : NSPreferencePane <NSTableViewDelegate, NSTableViewDataSource>

- (void)mainViewDidLoad;
- (IBAction)onSelectNetworkAction:(NSTableView *)sender;

@property (weak) IBOutlet NSTableView *networkServicesTableView;
@property (strong) NSMutableDictionary *config;
@property (weak) IBOutlet NSTextField *uuidTextField;
@property (weak) IBOutlet NSTextField *userDefinedNameTextField;
@property (weak) IBOutlet NSTextField *interfaceNameTextField;
@property (weak) IBOutlet NSTextField *interfaceHardwareTextField;
@property (weak) IBOutlet NSTextField *interfaceTypeTextField;
@property (weak) IBOutlet NSTextField *interfaceSubTypeTextField;
@property (weak) IBOutlet NSTextField *interfaceUserDefinedNameTextField;
@property (weak) IBOutlet NSTextField *dnsTextField;
@property (weak) IBOutlet NSTextField *ipv4MethodTextField;
@property (weak) IBOutlet NSTextField *ipv6MethodTextField;

@end
