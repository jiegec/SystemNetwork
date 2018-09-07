//
//  SystemNetwork.m
//  SystemNetwork
//
//  Created by MacBookAir on 2018/9/8.
//  Copyright © 2018 Jiajie Chen. All rights reserved.
//

#import "SystemNetwork.h"

@implementation SystemNetwork

static NSString * CONFIG_PATH = @"/Library/Preferences/SystemConfiguration/preferences.plist";

- (void)mainViewDidLoad
{
    NSData *data = [NSData dataWithContentsOfFile:CONFIG_PATH];
    [self setConfig:(NSMutableDictionary *)[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainersAndLeaves format:nil error:nil]];
    NSLog(@"%@", [self config]);
    
    [[self networkServicesTableView] setDelegate:self];
    [[self networkServicesTableView] setDataSource:self];
}

- (IBAction)onSelectNetworkAction:(NSTableView *)sender {
    NSInteger index = [sender clickedRow];
    NSDictionary *services = [self config][@"NetworkServices"];
    NSArray<NSString *> *keys = [services allKeys];
    NSDictionary *service = services[keys[index]];
    [[self uuidTextField] setStringValue:keys[index]];
    [[self userDefinedNameTextField] setStringValue:service[@"UserDefinedName"]];
    [[self interfaceNameTextField] setStringValue:service[@"Interface"][@"DeviceName"]];
    [[self interfaceHardwareTextField] setStringValue:service[@"Interface"][@"Hardware"]];
    [[self interfaceTypeTextField] setStringValue:service[@"Interface"][@"Type"]];
    [[self interfaceSubTypeTextField] setStringValue:service[@"Interface"][@"SubType"]];
    [[self interfaceUserDefinedNameTextField] setStringValue:service[@"Interface"][@"UserDefinedName"]];
    [[self ipv4MethodTextField] setStringValue:service[@"IPv4"][@"ConfigMethod"]];
    [[self ipv6MethodTextField] setStringValue:service[@"IPv6"][@"ConfigMethod"]];
}


#pragma mark -
#pragma mark NSTableViewDataSource Implementation

-  (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[self config][@"NetworkServices"] count];
}

#pragma mark -
#pragma mark NSTableViewDelegate Implementation

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 25;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTextField *textField = [[NSTextField alloc] init];
    [textField setEditable:NO];
    NSDictionary *services = [self config][@"NetworkServices"];
    NSArray<NSString *> *keys = [services allKeys];
    [textField setStringValue:services[keys[row]][@"UserDefinedName"]];
    [textField setBordered:NO];
    [textField setDrawsBackground:NO];
    [textField setTag:row];

    return textField;
}

@end
