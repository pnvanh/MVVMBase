//
//  ViewController.swift
//  MVVMBase
//
//  Created by Viet Anh on 19/08/2021.
//

import UIKit

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let st = UIStoryboard(name: "HomeVC", bundle: nil)
        guard let vc = st.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else { return }
        self.pushViewController(vc, animated: true)
        // Do any additional setup after loading the view.
    }
    
}
