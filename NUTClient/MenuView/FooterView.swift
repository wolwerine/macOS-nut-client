//
//  FooterView.swift
//  NUTClient
//
//  Created by Barna Fulop on 19.05.2026.
//
import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack {
            // Preferences Button
            if #available(macOS 14.0, *) {
                SettingsLink {
                    Label("Preferences...", systemImage: "gearshape")
                        .font(.system(size: 13, weight: .medium))
                }
                .buttonStyle(.plain)
                .onHover { inside in
                    if inside { NSCursor.pointingHand.push() } else { NSCursor.pop() }
                }
            } else {
                Button(action: {
                    if #available(macOS 13.0, *) {
                        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                    } else {
                        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
                    }
                    NSApp.activate(ignoringOtherApps: true)
                }) {
                    Label("Preferences...", systemImage: "gearshape")
                        .font(.system(size: 13, weight: .medium))
                }
                .buttonStyle(.plain)
                .onHover { inside in
                    if inside { NSCursor.pointingHand.push() } else { NSCursor.pop() }
                }
            }
            
            Spacer()
            
            // Quit Button
            Button(action: {
                NSApplication.shared.terminate(nil)
            }) {
                Label("Quit", systemImage: "xmark.circle")
                    .font(.system(size: 13, weight: .medium))
            }
            .buttonStyle(.plain)
            .onHover { inside in
                if inside { NSCursor.pointingHand.push() } else { NSCursor.pop() }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        // Match the width of the HeaderView exactly
        .frame(width: 300)
    }
}
