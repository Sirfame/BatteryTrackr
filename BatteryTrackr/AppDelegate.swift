//
//  AppDelegate.swift
//  BatteryTrackr
//
//  Created by Sirfame Lin on 1/21/19.
//  Copyright © 2019 Sirfame Lin. All rights reserved.
//

import Cocoa
import Foundation
import IOKit.ps

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    var batteryTimer: Timer!
    let popover = NSPopover()
    
    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = BatteryInfoViewController.freshController()
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
//    var helloWorldTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printQuote(_:)), userInfo: nil, repeats: true)
//    
//    @objc func sayHello(_ sender: Any?)
//    {
//        print("hello World")
//    }
    
    @objc func getBattery(_ sender: Any?) {
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        
        // Pull out a list of power sources
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
        
        // For each power source...
        for ps in sources {
            // Fetch the information for a given power source out of our snapshot
            let info = IOPSGetPowerSourceDescription(snapshot, ps).takeUnretainedValue() as! [String: AnyObject]
            
            // Pull out the name and capacity
            if let name = info[kIOPSNameKey] as? String,
                let capacity = info[kIOPSCurrentCapacityKey] as? Int,
                let max = info[kIOPSMaxCapacityKey] as? Int {
                print("\(name): \(capacity) of \(max)")
                writeTofile(text: "\(name): \(capacity) of \(max)")
            }
        }
    }
    
    func writeTofile(text: String) {
        let newFileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("batteryHistory.txt")
        
        if let fileUpdater = try? FileHandle(forUpdating: newFileUrl!) {
            fileUpdater.seekToEndOfFile()
            fileUpdater.write(text.data(using: .utf8)!)
            fileUpdater.write("\n".data(using: .utf8)!)
            fileUpdater.closeFile()
        }
        
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let fileURL = dir.appendingPathComponent(file)
//
//            do {
//                try text.write(to: fileURL, atomically: false, encoding: .utf8)
//            } catch {}
//
//            do {
//                let readText = try String(contentsOf: fileURL, encoding: .utf8)
//                print(readText)
//            } catch {}
//        }

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        batteryTimer.invalidate();
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.getBattery(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }


}

