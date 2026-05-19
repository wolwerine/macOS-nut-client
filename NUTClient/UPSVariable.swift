//
//  UPSVariable.swift
//  NUTClient
//
//  Created by Barna Fulop on 19.05.2026.
//
import Foundation

enum UPSVariable: String, CaseIterable {
    // Ambient
    case ambientTemperature = "ambient.temperature"
    case ambientTemperatureHigh = "ambient.temperature.high"
    
    // Battery
    case batteryCharge = "battery.charge"
    case batteryChargerStatus = "battery.charger.status"
    case batteryPacks = "battery.packs"
    case batteryRuntime = "battery.runtime"
    case batteryRuntimeLow = "battery.runtime.low"
    case batteryVoltage = "battery.voltage"
    
    // Device
    case deviceMfr = "device.mfr"
    case deviceModel = "device.model"
    case devicePart = "device.part"
    case deviceSerial = "device.serial"
    case deviceType = "device.type"
    
    // Driver
    case driverName = "driver.name"
    case driverParameterPollinterval = "driver.parameter.pollinterval"
    case driverParameterPort = "driver.parameter.port"
    case driverParameterSynchronous = "driver.parameter.synchronous"
    case driverVersion = "driver.version"
    case driverVersionInternal = "driver.version.internal"
    
    // Input
    case inputFrequency = "input.frequency"
    case inputFrequencyHigh = "input.frequency.high"
    case inputFrequencyLow = "input.frequency.low"
    case inputFrequencyNominal = "input.frequency.nominal"
    case inputTransferBoostHigh = "input.transfer.boost.high"
    case inputTransferHigh = "input.transfer.high"
    case inputTransferLow = "input.transfer.low"
    case inputTransferTrimLow = "input.transfer.trim.low"
    case inputVoltage = "input.voltage"
    case inputVoltageNominal = "input.voltage.nominal"
    
    // Outlets
    case outlet1DelayShutdown = "outlet.1.delay.shutdown"
    case outlet1DelayStart = "outlet.1.delay.start"
    case outlet1Id = "outlet.1.id"
    case outlet1Status = "outlet.1.status"
    
    case outlet2DelayShutdown = "outlet.2.delay.shutdown"
    case outlet2DelayStart = "outlet.2.delay.start"
    case outlet2Id = "outlet.2.id"
    case outlet2Status = "outlet.2.status"
    
    // Output
    case outputCurrent = "output.current"
    case outputCurrentNominal = "output.current.nominal"
    case outputFrequency = "output.frequency"
    case outputFrequencyNominal = "output.frequency.nominal"
    case outputPhases = "output.phases"
    case outputVoltage = "output.voltage"
    case outputVoltageNominal = "output.voltage.nominal"
    
    // UPS General
    case upsBeeperStatus = "ups.beeper.status"
    case upsDescription = "ups.description"
    case upsFirmware = "ups.firmware"
    case upsLoad = "ups.load"
    case upsMfr = "ups.mfr"
    case upsModel = "ups.model"
    case upsPower = "ups.power"
    case upsPowerNominal = "ups.power.nominal"
    case upsRealPower = "ups.realpower"
    case upsSerial = "ups.serial"
    case upsStatus = "ups.status"
    case upsTestResult = "ups.test.result"
}

extension UPSVariable {
    
    // MARK: - Display Name
    var displayName: String {
        switch self {
        // Ambient
        case .ambientTemperature: return "Temperature"
        case .ambientTemperatureHigh: return "High Temp Threshold"
            
        // Battery
        case .batteryCharge: return "Charge Level"
        case .batteryChargerStatus: return "Charger Status"
        case .batteryPacks: return "External Packs"
        case .batteryRuntime: return "Time Remaining"
        case .batteryRuntimeLow: return "Low Battery Warning at"
        case .batteryVoltage: return "Battery Voltage"
            
        // Device & Driver
        case .deviceMfr, .upsMfr: return "Manufacturer"
        case .deviceModel, .upsModel: return "Model"
        case .devicePart: return "Part Number"
        case .deviceSerial, .upsSerial: return "Serial Number"
        case .deviceType: return "Device Type"
        case .driverName: return "Driver"
        case .driverParameterPollinterval: return "Poll Interval"
        case .driverParameterPort: return "Port"
        case .driverParameterSynchronous: return "Synchronous Mode"
        case .driverVersion: return "Driver Version"
        case .driverVersionInternal: return "Internal Version"
            
        // Input
        case .inputFrequency: return "Input Frequency"
        case .inputFrequencyHigh: return "Frequency High Limit"
        case .inputFrequencyLow: return "Frequency Low Limit"
        case .inputFrequencyNominal: return "Nominal Frequency"
        case .inputTransferBoostHigh: return "Boost Transfer High"
        case .inputTransferHigh: return "High Voltage Transfer"
        case .inputTransferLow: return "Low Voltage Transfer"
        case .inputTransferTrimLow: return "Trim Transfer Low"
        case .inputVoltage: return "Input Voltage"
        case .inputVoltageNominal: return "Nominal Input"
            
        // Outlets
        case .outlet1DelayShutdown, .outlet2DelayShutdown: return "Shutdown Delay"
        case .outlet1DelayStart, .outlet2DelayStart: return "Startup Delay"
        case .outlet1Id, .outlet2Id: return "Outlet ID"
        case .outlet1Status, .outlet2Status: return "Outlet Status"
            
        // Output
        case .outputCurrent: return "Output Current"
        case .outputCurrentNominal: return "Nominal Current"
        case .outputFrequency: return "Output Frequency"
        case .outputFrequencyNominal: return "Nominal Frequency"
        case .outputPhases: return "Phases"
        case .outputVoltage: return "Output Voltage"
        case .outputVoltageNominal: return "Nominal Output"
            
        // UPS General
        case .upsBeeperStatus: return "Beeper Status"
        case .upsDescription: return "Description"
        case .upsFirmware: return "Firmware"
        case .upsLoad: return "Current Load"
        case .upsPower: return "Apparent Power"
        case .upsPowerNominal: return "Nominal Power"
        case .upsRealPower: return "Real Power"
        case .upsStatus: return "UPS Status"
        case .upsTestResult: return "Last Self-Test"
        }
    }
    
    // MARK: - Value Formatting
    func formatLiveValue(_ value: String) -> String {
        // exit for empty or invalid data so we don't return things like "-- V"
        guard !value.isEmpty, value != "--" else { return "--" }
        
        switch self {
            
        // Voltages (V)
        case .inputVoltage, .inputVoltageNominal, .inputTransferHigh, .inputTransferLow,
             .inputTransferBoostHigh, .inputTransferTrimLow, .outputVoltage,
             .outputVoltageNominal, .batteryVoltage:
            return "\(value) V"
            
        // Frequencies (Hz)
        case .inputFrequency, .inputFrequencyHigh, .inputFrequencyLow, .inputFrequencyNominal,
             .outputFrequency, .outputFrequencyNominal:
            if let frequency = Double(value) {
                let formattedFrequency = String(format: "%.2f", frequency/10)
                return "\(formattedFrequency) Hz"
            }
            return "\(value) Hz"
            
        // Percentages (%)
        case .batteryCharge, .upsLoad:
            return "\(value)%"
            
        // Temperatures (°C) - NUT natively reports in Celsius
        case .ambientTemperature, .ambientTemperatureHigh:
            return "\(value) °C"
            
        // Power (W / VA)
        case .upsRealPower:
            return "\(value) W"
        case .upsPower, .upsPowerNominal:
            return "\(value) VA"
            
        // Current (A)
        case .outputCurrent, .outputCurrentNominal:
            return "\(value) A"
            
        // Time / Runtime Handling (Seconds -> Hours/Minutes)
        case .batteryRuntime, .batteryRuntimeLow, .outlet1DelayShutdown,
             .outlet1DelayStart, .outlet2DelayShutdown, .outlet2DelayStart:
            if let seconds = Int(value) {
                let minutes = seconds / 60
                
                if minutes > 0 {
                    return "\(minutes) min"
                } else {
                    return "\(seconds) sec"
                }
            }
            return "\(value) s"
            
        // Humanize the raw UPS status abbreviations
        case .upsStatus:
            let upperVal = value.uppercased()
            if upperVal.contains("OL") { return "Online (AC Power)" }
            if upperVal.contains("OB") { return "On Battery" }
            if upperVal.contains("LB") { return "Low Battery!" }
            if upperVal.contains("CHRG") { return "Charging" }
            if upperVal.contains("DISCHRG") { return "Discharging" }
            return value
            
        // Beeper
        case .upsBeeperStatus:
            return value.lowercased() == "enabled" ? "Active" : "Muted"
            
        // Default (Strings, IDs, Models) - Return exactly as received
        default:
            return value
        }
    }
}

// Define the UI Groups
enum UPSCategory: String, CaseIterable {
    case ambient = "Ambient"
    case battery = "Battery"
    case device = "Device Info"
    case driver = "Driver Data"
    case input = "Input"
    case outlets = "Outlets"
    case output = "Output"
    case upsGeneral = "UPS General"
}

// Add a category mapper to your existing UPSVariable enum
extension UPSVariable {
    var category: UPSCategory {
        if rawValue.hasPrefix("ambient") { return .ambient }
        if rawValue.hasPrefix("battery") { return .battery }
        if rawValue.hasPrefix("device") { return .device }
        if rawValue.hasPrefix("driver") { return .driver }
        if rawValue.hasPrefix("input") { return .input }
        if rawValue.hasPrefix("outlet") { return .outlets }
        if rawValue.hasPrefix("output") { return .output }
        return .upsGeneral
    }
}


