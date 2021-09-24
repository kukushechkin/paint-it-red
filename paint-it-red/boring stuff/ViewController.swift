//
//  ViewController.swift
//  paint-it-red
//
//  Created by Kukushkin, Vladimir on 24.9.2021.
//

import UIKit
import WebKit
import SwiftUI

class MainViewController: UIHostingController<MainView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: MainView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
