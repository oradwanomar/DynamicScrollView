//
//  ViewController.swift
//  DemoScrollView
//
//  Created by O M A R on 30/09/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func routeToState1(_ sender: Any) {
        let vc = DemoScrollViewController(viewModel: ScrollViewModel(currentState: .case1))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func routeToState2(_ sender: Any) {
        let vc = DemoScrollViewController(viewModel: ScrollViewModel(currentState: .case2))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func routeToState3(_ sender: Any) {
        let vc = DemoScrollViewController(viewModel: ScrollViewModel(currentState: .case3))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

