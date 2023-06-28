//
//  PuppiesViewController.swift
//  AdoptAPup
//
//  Created by Catherine Shing on 6/27/23.
//

import UIKit

class PuppiesViewController: UIViewController {
    
    private let viewModel: PuppiesControllerViewModel
    
    init(_ viewModel: PuppiesControllerViewModel = PuppiesControllerViewModel()) {
        print("inside pup vm init")
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("before background")
        self.view.backgroundColor = .systemBlue
        
        print("before token")
    }
}
