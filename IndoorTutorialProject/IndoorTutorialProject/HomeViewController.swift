//
//  HomeViewController.swift
//  IndoorTutorialProject
//
//  Created by DABEEO on 2020/03/02.
//  Copyright © 2020 DABEEO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, RouterProtocol {
    
    @IBOutlet var tbView: UITableView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        tbView.dataSource = viewModel
        tbView.delegate = viewModel
        
        viewModel.delegate = self
        
        self.navigationItem.backBarButtonItem?.action = #selector(hideVC)
    }
    
    func getViewController(className: String) -> UIViewController {
        let vc: UIViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: className)
        return vc
    }
    
    @objc func hideVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - RouterProtocol
    func showVC(_ className: String, animated: Bool) {
        let vc: UIViewController = getViewController(className: className)
        
        self.navigationController?.pushViewController(vc, animated: animated)
    }

}
