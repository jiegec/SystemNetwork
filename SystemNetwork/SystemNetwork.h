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
@property (weak) IBOutlet NSTableView *networkServicesTableView;

@property (strong) NSMutableDictionary *config;

@end
