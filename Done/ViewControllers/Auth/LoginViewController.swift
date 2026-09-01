//
//  LoginViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let bottomSheet = UIView()
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LoginAndRegistrationViewStrings.loginButtonTittle.rawValue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    func configureUI() {
        view.backgroundColor = .red
        view.addSubview(bottomSheet)
        bottomSheet.backgroundColor = .white
        bottomSheet.layer.cornerRadius = 16
        bottomSheet.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalToSuperview()
        }
        
        bottomSheet.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        loginButton.addTarget(self, action: #selector(loginButtonTapped( _:)), for: .touchUpInside)
    }
    
    private func goToMainScreen() {
        let controller = MainScreenViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func loginButtonTapped(_ Sender: UIButton ) {
        goToMainScreen()
    }
}
