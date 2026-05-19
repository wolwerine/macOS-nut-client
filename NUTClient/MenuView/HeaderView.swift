//
//  HeaderView.swift
//  NUTstate
//
//  Created by Barna Fulop on 19.05.2026.
//
import SwiftUI
import Combine

struct HeaderView: View {
    @ObservedObject var state: UPSStateMachine
    
    // Determine title text based on the 3 requested states
    var stateTitle: String {
        if state.currentStatus.contains("LB") { return "Battery Low" }
        if state.currentStatus.contains("OB") { return "Running on Battery" }
        return "Running on AC" // Default (OL - Online)
    }
    
    // Match colors to state
    var stateColor: Color {
        if state.currentStatus.contains("LB") { return .red }
        if state.currentStatus.contains("OB") { return .orange }
        return .green
    }
    
    // Match icons to state
    var stateIcon: String {
        if state.currentStatus.contains("LB") { return "battery.25" }
        if state.currentStatus.contains("OB") { return "battery.50" }
        return "bolt.fill.batteryblock"
    }

    var body: some View {
        VStack(spacing: 12) {
            // Top Half: Icon, Title, IP
            HStack(spacing: 12) {
                // Large colored icon box
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(stateColor.opacity(0.2))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: stateIcon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(stateColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(stateTitle)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(state.hostString)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            
            Divider()
                        
            // Bottom Half: Stats List
            VStack(spacing: 8) {
                // 1. Connection Status
                HStack {
                    Image(systemName: "globe")
                        .foregroundColor(.secondary)
                        .frame(width: 20) // Ensures all icons align perfectly
                    Text("NUT Status")
                        .foregroundColor(.secondary)
                        .font(.system(size: 13))
                    
                    Spacer()
                    
                    Text(state.isConnected ? "Connected" : "Disconnected")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(state.isConnected ? .primary : .red)
                }
                
                // 2. Battery Charge Level
                HStack {
                    Image(systemName: "batteryblock")
                        .foregroundColor(.secondary)
                        .frame(width: 20)
                    Text("Battery Level")
                        .foregroundColor(.secondary)
                        .font(.system(size: 13))
                    
                    Spacer()
                    
                    Text("\(state.batteryCharge)%")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                }
                
                // 3. Current Load
                HStack {
                    Image(systemName: "bolt.square")
                        .foregroundColor(.secondary)
                        .frame(width: 20)
                    Text("Current Load")
                        .foregroundColor(.secondary)
                        .font(.system(size: 13))
                    
                    Spacer()
                    
                    Text("\(state.loadPercentage)%")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(14)
        .frame(width: 300)
    }
}
