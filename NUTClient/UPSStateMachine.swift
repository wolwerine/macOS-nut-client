//
//  UPSStateMachine.swift
//  NUTClient
//
//  Created by Barna Fulop on 19.05.2026.
//
import Foundation
import Combine

class UPSStateMachine: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var hostString: String = ""
    
    // The dictionary mapping the option name to its received value
    @Published var variables: [String: String] = [:]
    
    // MARK: - Easily Accessible Properties
    // Using the new strongly-typed enum
    
    var currentStatus: String {
        variables[UPSVariable.upsStatus.rawValue] ?? "Unknown"
    }
    
    var isRunningOnBattery: Bool {
        currentStatus.contains("OB")
    }
    
    var isBatteryLow: Bool {
        currentStatus.contains("LB")
    }
    
    var loadPercentage: String {
        variables[UPSVariable.upsLoad.rawValue] ?? "--"
    }
    
    var batteryCharge: String {
        variables[UPSVariable.batteryCharge.rawValue] ?? "--"
    }
    
    // Helper to get a sorted list of all dynamic keys for the Preferences window
    var allKeysSorted: [String] {
        variables.keys.sorted()
    }
    
    // MARK: - New Helper Methods (Optional but handy)
    
    /// Safely fetches any value using the enum to prevent typos
    func getValue(for variable: UPSVariable) -> String? {
        return variables[variable.rawValue]
    }
}
