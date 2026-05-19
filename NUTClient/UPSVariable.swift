//
//  UPSVariable.swift
//  NUTClient
//
//  Created by Barna Fulop on 19.05.2026.
//
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


