//
//  SystemNetwork.swift
//  SystemNetwork
//
//  Created by MacBookAir on 2018/9/8.
//  Copyright © 2018 Jiajie Chen. All rights reserved.
//

import Cocoa
import Foundation
import PreferencePanes

class SystemNetwork: NSPreferencePane {
    @IBOutlet var networkServicesTableView: NSTableView!
    @IBOutlet var uuidTextField: NSTextField!
    @IBOutlet var userDefinedNameTextField: NSTextField!
    @IBOutlet var interfaceNameTextField: NSTextField!
    @IBOutlet var interfaceHardwareTextField: NSTextField!
    @IBOutlet var interfaceTypeTextField: NSTextField!
    @IBOutlet var interfaceSubTypeTextField: NSTextField!
    @IBOutlet var interfaceUserDefinedNameTextField: NSTextField!
    @IBOutlet var dnsTextField: NSTextField!
    @IBOutlet var ipv4MethodTextField: NSTextField!
    @IBOutlet var ipv6MethodTextField: NSTextField!

    var config: [String: Any]?

    let CONFIG_FILE = "/Library/Preferences/SystemConfiguration/preferences.plist"

    override func mainViewDidLoad() {
        do {
            let data = try
                Data(contentsOf: URL(fileURLWithPath: CONFIG_FILE))
            config = try
                PropertyListSerialization.propertyList(
                    from
                        : data, options
                        : PropertyListSerialization.MutabilityOptions
                        .mutableContainersAndLeaves,
                    format
                        : nil
                ) as? [String: Any]

            networkServicesTableView.reloadData()
        } catch let error {
            print("Got error \(error)")
        }
    }

    @IBAction func onSelectNetworkAction(sender: NSTableView) {
        let index = sender.clickedRow
        guard let services =
            config? ["NetworkServices"] else { return
        }
        guard let dict = services as? [String: Any] else { return }

        let keys = dict.keys.sorted()

        guard let service = dict[keys[index]] as? [String: Any] else { return }

        uuidTextField.stringValue =
            keys[index]
        userDefinedNameTextField.stringValue =
            service["UserDefinedName"] as? String ?? ""
        interfaceNameTextField.stringValue = (service["Interface"] as? [String: Any])?["DeviceName"] as? String ?? ""
        interfaceHardwareTextField.stringValue = (service["Interface"] as? [String: Any])?["Hardware"] as? String ?? ""
        interfaceTypeTextField.stringValue = (service["Interface"] as? [String: Any])?["Type"] as? String ?? ""
        interfaceSubTypeTextField.stringValue = (service["Interface"] as? [String: Any])?["SubType"] as? String ?? ""
        interfaceUserDefinedNameTextField.stringValue = (service["Interface"] as? [String: Any])?["UserDefinedName"] as? String ?? ""
        interfaceUserDefinedNameTextField.stringValue = (service["Interface"] as? [String: Any])?["UserDefinedName"] as? String ?? ""
        ipv4MethodTextField.stringValue = (service["IPv4"] as? [String: Any])?["ConfigMethod"] as? String ?? ""
        ipv6MethodTextField.stringValue = (service["IPv6"] as? [String: Any])?["ConfigMethod"] as? String ?? ""

        let dns = (service["DNS"] as? [String: Any])?["ServerAddresses"] as? [String]
        dnsTextField.stringValue = dns?.joined(separator: ", ") ?? ""
    }
}

extension SystemNetwork: NSTableViewDataSource {
    func numberOfRows(in _: NSTableView) -> Int {
        guard let services = config?["NetworkServices"] else { return 0 }
        guard let dict = services as? [String: Any] else { return 0 }
        return dict.count
    }
}

extension SystemNetwork: NSTableViewDelegate {
    func tableView(_
        : NSTableView, heightOfRow _
        : Int)
        -> CGFloat { return 25 }

    func tableView(_
        : NSTableView, viewFor _
        : NSTableColumn?, row: Int)
        -> NSView? {
        let textField = NSTextField()
        textField.isEditable = false

        guard let services = config? ["NetworkServices"] else { return nil }
        guard let dict = services as? [String: Any] else { return nil }
        let keys = dict.keys.sorted()

        guard let service = dict[keys[row]] as? [String: Any] else { return nil }
        textField.stringValue = service["UserDefinedName"] as! String
        textField.isBordered = false
        textField.drawsBackground = false
        textField.tag = row

        return textField
    }
}
