//
//  NUTClientApp.swift
//  NUTClient
//
//  Created by Barna Fulop on 18.05.2026.
//
//
import SwiftUI
import AppKit
import Combine

@main
struct NUTClientNativeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            PreferencesView(client: appDelegate.sharedClient, state: appDelegate.sharedClient.state)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    var statusItem: NSStatusItem!
    var popover: NSPopover!
    
    let upsState = UPSStateMachine()
    lazy var sharedClient: NUTClient = {
        let savedHost = UserDefaults.standard.string(forKey: "nutHost") ?? "127.0.0.1"
        let savedPort = UInt16(UserDefaults.standard.string(forKey: "nutPort") ?? "3493") ?? 3493
        let savedUser = UserDefaults.standard.string(forKey: "nutUser")
        let savedPass = UserDefaults.standard.string(forKey: "nutPass")
        
        return NUTClient(
            state: upsState,
            host: savedHost,
            port: savedPort,
            username: savedUser?.isEmpty == false ? savedUser : nil,
            password: savedPass?.isEmpty == false ? savedPass : nil
        )
    }()
    
    // Used to observe background changes for the icon
    private var cancellables = Set<AnyCancellable>()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "bolt.fill.batteryblock",
                                   accessibilityDescription: "NUT Client")
        }
        
        let menu = NSMenu()
        menu.delegate = self // This tells the menu to ask us for items before opening
        statusItem.menu = menu
        
        sharedClient.connect()
        
        upsState.$variables
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateMenuIcon()
            }
            .store(in: &cancellables)
    }
    
    private func updateMenuIcon() {
        if let button = statusItem.button {
            let iconName = upsState.isRunningOnBattery ? "menuIcon.battery" : "menuIcon.power"
            button.image = NSImage(named: iconName)
        }
    }

    // MARK: - NSMenuDelegate
    
    func menuWillOpen(_ menu: NSMenu) {
        menu.removeAllItems()
        
        // --- 1. Rich SwiftUI Header ---
        let headerView = HeaderView(state: sharedClient.state) // Assuming you use the state machine!
        let headerController = NSHostingController(rootView: headerView)
        headerController.view.frame.size = NSSize(width: 300, height: 155)
        
        let headerMenuItem = NSMenuItem()
        headerMenuItem.view = headerController.view
        menu.addItem(headerMenuItem)
        
        // --- 2. Dynamic Categorized Variables List ---
        let savedVars = UserDefaults.standard.stringArray(forKey: "SelectedUPSVars") ?? []
        
        if savedVars.isEmpty {
            let emptyItem = NSMenuItem(title: "No variables selected.", action: nil, keyEquivalent: "")
            emptyItem.isEnabled = false
            menu.addItem(emptyItem)
        } else {
            // Group the selected strings back into their Enums so we can sort them by category
            let selectedEnums = savedVars.compactMap { UPSVariable(rawValue: $0) }
            
            for category in UPSCategory.allCases {
                let varsInCategory = selectedEnums.filter { $0.category == category }
                
                // Only draw the category header if the user selected something inside it
                if !varsInCategory.isEmpty {
                    menu.addItem(NSMenuItem.separator())
                    
                    // Create the Bold Category Header
                    let headerItem = NSMenuItem()
                    let attrs: [NSAttributedString.Key: Any] = [
                        .font: NSFont.systemFont(ofSize: 13, weight: .bold),
                        .foregroundColor: NSColor.secondaryLabelColor
                    ]
                    headerItem.attributedTitle = NSAttributedString(string: category.rawValue.uppercased(), attributes: attrs)
                    headerItem.isEnabled = false
                    menu.addItem(headerItem)
                    
                    // Add the properties under the header
                    for variable in varsInCategory {
                        if let liveValue = sharedClient.state.variables[variable.rawValue] {
                            let displayTitle = "\(variable.displayName): \(variable.formatLiveValue(liveValue))"
                            
                            let item = NSMenuItem(title: displayTitle, action: nil, keyEquivalent: "")
                            item.isEnabled = false
                            item.indentationLevel = 1 // Pushes the text to the right, grouping it under the header visually
                            menu.addItem(item)
                        }
                    }
                }
            }
        }
        
        menu.addItem(NSMenuItem.separator())
        
        // --- 3. SwiftUI Footer ---
        let footerView = FooterView()
        let footerController = NSHostingController(rootView: footerView)
        // Height of 36 gives nice padding around the buttons
        footerController.view.frame.size = NSSize(width: 300, height: 36)
        
        let footerMenuItem = NSMenuItem()
        footerMenuItem.view = footerController.view
        menu.addItem(footerMenuItem)
    }
}
