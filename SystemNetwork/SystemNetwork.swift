//
//  SystemNetwork.swift
//  SystemNetwork
//
//  Created by MacBookAir on 2018/9/8.
//  Copyright © 2018 Jiajie Chen. All rights reserved.
//

import Foundation
import Cocoa
import PreferencePanes

class SystemNetwork : NSPreferencePane {
    
    @IBOutlet weak var networkServicesTableView: NSTableView!
    @IBOutlet weak var uuidTextField: NSTextField!
    @IBOutlet weak var userDefinedNameTextField: NSTextField!
    @IBOutlet weak var interfaceNameTextField: NSTextField!
    @IBOutlet weak var interfaceHardwareTextField: NSTextField!
    @IBOutlet weak var interfaceTypeTextField: NSTextField!
    @IBOutlet weak var interfaceSubTypeTextField: NSTextField!
    @IBOutlet weak var interfaceUserDefinedNameTextField: NSTextField!
    @IBOutlet weak var dnsTextField: NSTextField!
    @IBOutlet weak var ipv4MethodTextField: NSTextField!
    @IBOutlet weak var ipv6MethodTextField: NSTextField!
    
    var config: [String:Any]?
    
    let CONFIG_FILE = "/Library/Preferences/SystemConfiguration/preferences.plist";

    override func mainViewDidLoad() {
        do {
            let data = try Data.init(contentsOf: URL(fileURLWithPath: CONFIG_FILE));
            config = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as? [String: Any];
            
        } catch let error {
            print("Got error \(error)");
        }
    }
    
    @IBAction func onSelectNetworkAction(sender: NSTableView) {
        
    }
}


extension SystemNetwork : NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        guard let services = config?["NetworkServices"] else {
            return 0;
        }
        guard let dict = services as? [String : Any] else {
            return 0;
        }
        return dict.count;
    }
}

extension SystemNetwork: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let textField = NSTextField();
        textField.isEditable = false;
        
        guard let services = config?["NetworkServices"] else {
            return nil;
        }
        guard let dict = services as? [String : Any] else {
            return nil;
        }
        let keys = dict.keys.sorted();
        
        guard let service = dict[keys[row]] as? [String: Any] else {
            return nil;
        }
        textField.stringValue = service["UserDefinedName"] as! String;
        textField.isBordered = false;
        textField.drawsBackground = false;
        textField.tag = row;
        
        return textField;
    }
}
