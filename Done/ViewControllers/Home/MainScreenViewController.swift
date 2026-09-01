//
//  MainScreenViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//



import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    let bottomSheet = UIView()
    let goBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(GoBackStrings.goBackButtonTittle.rawValue, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        configureUI()
    
        super.viewDidLoad()
        }
    
    
    func configureUI() {
        view.backgroundColor = .green
        view.addSubview(bottomSheet)
        bottomSheet.backgroundColor = .white
        bottomSheet.layer.cornerRadius = 16
        bottomSheet.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalToSuperview()
        }
        
        bottomSheet.addSubview(goBackButton)
        goBackButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        goBackButton.addTarget(self, action: #selector(backButtonTapped( _:)), for: .touchUpInside)
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)

    }
    
    @objc private func backButtonTapped(_ Sender: UIButton ) {
        goBack()
    }
}
