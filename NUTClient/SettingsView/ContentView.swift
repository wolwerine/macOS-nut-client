//
//  ContentView.swift
//  NUTClient
//
//  Created by Barna Fulop on 18.05.2026.
//
import SwiftUI

struct ContentView: View {
    // Inject the State Machine
    @ObservedObject var state: UPSStateMachine
    @StateObject private var prefs = AppPreferences()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Header
            HStack {
                Image(systemName: state.isBatteryLow ? "battery.25" : (state.isRunningOnBattery ? "battery.50" : "bolt.fill.batteryblock"))
                    .foregroundColor(state.isBatteryLow ? .red : (state.isRunningOnBattery ? .orange : .green))
                    .font(.title2)
                
                Text(state.isConnected ? "UPS Connected" : "Disconnected")
                    .fontWeight(.bold)
                
                Spacer()
                Circle()
                    .fill(state.isConnected ? Color.green : Color.red)
                    .frame(width: 8, height: 8)
            }
            .padding(.bottom, 4)
            
            Divider()
            
            // Dynamic Data List
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    if prefs.selectedVars.isEmpty {
                        Text("No variables selected.\nOpen Preferences to add some.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        // Look up the selected keys directly in the state dictionary
                        ForEach(prefs.selectedVars, id: \.self) { varName in
                            if let liveValue = state.variables[varName] {
                                HStack {
                                    Text(varName)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text(liveValue)
                                        .fontWeight(.semibold)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: 300)
            
            // Footer Actions
            HStack {
                if #available(macOS 14.0, *) {
                    SettingsLink { Text("Preferences") }
                    .buttonStyle(.plain)
                } else {
                    Button("Preferences") {
                        if #available(macOS 13.0, *) {
                            NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                        } else {
                            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .keyboardShortcut("q")
            }
            .padding(.top, 4)
        }
        .padding()
        .frame(width: 350)
    }
}
