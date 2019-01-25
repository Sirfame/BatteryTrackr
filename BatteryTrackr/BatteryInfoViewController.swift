//
//  BatteryInfoViewController.swift
//  BatteryTrackr
//
//  Created by Lin, Sirfame on 1/24/19.
//  Copyright © 2019 Sirfame Lin. All rights reserved.
//

import Cocoa

class BatteryInfoViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

}

extension BatteryInfoViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> BatteryInfoViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("BatteryInfoViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? BatteryInfoViewController else {
            fatalError("Why cant i find BatteryInfoViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
