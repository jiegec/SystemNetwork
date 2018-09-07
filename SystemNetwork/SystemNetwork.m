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
    NSArray *keys = [services allKeys];
    [textField setStringValue:services[keys[row]][@"UserDefinedName"]];
    
    return textField;
}

@end
