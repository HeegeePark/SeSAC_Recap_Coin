//
//  BaseViewController.swift
//  SeSAC_Recap_Coin
//
//  Created by 박희지 on 2/27/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
        configureNavigationBar()
    }
    
    func configureHierarchy() {
    }
    
    func configureLayout() {
    }
    
    func configureView() {
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .accentColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = ""
    }
    
    func showToast(_ message: String) {
        view.makeToast(message, duration: 2, position: .center)
    }
    
    func showAlert(title: String, message: String, ok: String, handler: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            handler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
