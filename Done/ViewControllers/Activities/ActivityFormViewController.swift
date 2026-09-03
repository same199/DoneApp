//
//  ActivityFormViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//



import UIKit

class ActivityFormViewController: UIViewController {
    let navigationBar = AppNavigationBar()
    let goBackButton = BackButtons()
    let addTask = AddTaskButton()
    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        }
    
    func configureUI() {
        view.backgroundColor = .blue
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(60)
        }
        navigationBar.addSubview(goBackButton)
        goBackButton.setTitle(GoBackStrings.goBackButtonTittle.rawValue, for: .normal)
        goBackButton.setTitleColor(.black, for: .normal)
        goBackButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(50)
        }
        goBackButton.addTarget(self, action: #selector(backButtonTapped( _:)), for: .touchUpInside)
        view.addSubview(addTask)
        addTask.setTitle("+", for: .normal)
        addTask.snp.makeConstraints { make in
            make.size.equalTo(56)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
               }
    }
    
    
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonTapped(_ Sender: UIButton ) {
        goBack()
    }
}
